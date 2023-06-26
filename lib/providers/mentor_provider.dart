import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../apis/location.dart';
import '../apis/mentor.dart';
import '../models/media_object.dart';
import '../models/mentor.dart';
import '../models/mentor_review.dart';
import '../models/token.dart';
import '../utils/cache.dart';
import '../utils/constants.dart';

class MentorProvider extends ChangeNotifier {
  Mentor _mentor = Mentor.empty();

  List<Mentor> _mentors = [];
  List<MentorReview> _reviews = [];

  Mentor get mentor => _mentor;

  List<Mentor> get mentors => _mentors;

  List<MentorReview> get reviews => _reviews;

  set setMentor(Mentor mnt) {
    _mentor = mnt;
    notifyListeners();
  }

  set appendToMentors(List<Mentor> mnts) {
    _mentors.addAll(mnts);
    notifyListeners();
  }

  set appendToMentorReviews(List<MentorReview> mentorReviews) {
    _reviews.addAll(mentorReviews);
    notifyListeners();
  }

  Future<Tokens> registerMentor() {
    return registerMentorAPI(_mentor.toJson());
  }

  Future<void> getInitialMentors(String token) async {
    final mentors = await getAllMentorsAPI(token, 10);

    _mentors = mentors;
    notifyListeners();
  }

  Future<void> getInitialMentorReviews(String id) async {
    _reviews = await getMentorReviewsAPI(id, 10);
    notifyListeners();
  }

  Future postMentorReview(
    String token,
    String review,
    int rating,
    String id,
  ) async {
    final body = {
      "id": id,
      "rating": rating,
      "reviewtext": review,
    };

    _mentors[_mentors.indexWhere((mnt) => mnt.id == id)].reviews_count + 1;
    await getInitialMentorReviews(id);

    return await postMentorReviewAPI(token, body);
  }

  Future<void> followMentor(String token, int idx) async {
    final followMentorAPIRes = await followMentorAPI(
      token,
      _mentors[idx].id!,
    );

    if (followMentorAPIRes) {
      if (_mentors[idx].followed) {
        _mentors[idx].followers_count--;
      } else {
        _mentors[idx].followers_count++;
      }

      _mentors[idx].followed = !_mentors[idx].followed;
      notifyListeners();
    }
  }

  Future<void> updateUserLocation(Position loc) async {
    List areas = await reverseGeocoding(
      loc.latitude.toString(),
      loc.longitude.toString(),
    );

    final areasLen = areas.length;
    final lastIdx = areasLen - 4;

    String area = "";

    areas.asMap().forEach((idx, val) {
      if (idx < lastIdx) {
        area += val + " ";
      }
    });

    area.trim();

    updateMentor('area', area);
    updateMentor('city', areas[areasLen - 4]);
    updateMentor('state', areas[areasLen - 3]);
    updateMentor('country', areas[areasLen - 2]);
    updateMentor('pinCode', areas[areasLen - 1].toString());

    notifyListeners();
  }

  void updateMentor(String key, dynamic value, [String? token]) {
    Map<String, dynamic> updates = {};

    updates["location"] = {
      "country": mentor.country,
      "state": mentor.state,
      "city": mentor.city,
      "area": mentor.area,
      "pincode": mentor.pinCode,
    };

    updates["education"] = mentor.education;

    if (key == 'avatar') {
      mentor.avatar = MediaObject(
        key: value,
        url: "$mediaHost/$value",
      );

      updates["avatar"] = {
        "key": value,
        "url": "$mediaHost/$value",
      };
    }

    if (key == 'id') {
      mentor.id = value;
      updates["id"] = value;
    }

    if (key == 'name') {
      mentor.name = value;
      updates["name"] = value;
    }

    if (key == 'username') {
      mentor.username = value;
      updates["username"] = value;
    }

    if (key == 'audience') {
      mentor.audience = value;
      updates["audience"] = value;
    }

    if (key == 'dob') {
      mentor.dob = value;
      updates["dob"] = value;
    }

    if (key == 'shortbio') {
      mentor.shortbio = value;
      updates["shortbio"] = value;
    }

    if (key == 'description') {
      mentor.description = value;
      updates["description"] = value;
    }

    if (key == 'phoneNumber') {
      mentor.phoneNumber = value;
      updates["phonenumber"] = value;
    }

    if (key == 'email') {
      mentor.email = value;
      updates["email"] = value;
    }

    if (key == 'field') {
      mentor.field = value;
      updates["field"] = value;
    }

    if (key == 'account_plan') {
      mentor.account_plan = value;
      updates["account_plan"] = value;
    }

    if (key == 'account_plan_details') {
      mentor.account_plan_details = value;
      updates["account_plan_details"] = value;
    }

    if (key == 'specialization') {
      mentor.specialization = value;
      updates["specialization"] = value;
    }

    if (key == 'linkedin') {
      mentor.linkedin = value;
      updates["linkedin"] = value;
    }

    if (key == 'interests') {
      mentor.interests = value;
      updates["interests"] = value;
    }

    if (key == 'total_experience') {
      mentor.total_experience = value;
      updates["total_experience"] = value;
    }

    if (key == 'experience') {
      mentor.experience.add(value);
      updates["experience"].add(value);
    }

    if (key == 'availability') {
      mentor.availability = value;
      updates["availability"] = value;
    }

    if (key == 'city') {
      mentor.city = value;
      updates["location"]["city"] = value;
    }

    if (key == 'area') {
      mentor.area = value;
      updates["location"]["area"] = value;
    }

    if (key == 'state') {
      mentor.state = value;
      updates["location"]["state"] = value;
    }

    if (key == 'country') {
      mentor.country = value;
      updates["location"]["country"] = value;
    }

    if (key == 'pinCode') {
      mentor.pinCode = value;
      updates["location"]["pincode"] = value;
    }

    if (key == 'education') {
      mentor.education.add(value);
      updates["education"].add(value);
    }

    if (key == 'skills') {
      mentor.education[0].skills = value;
      updates["skills"] = value;
    }

    notifyListeners();

    if (token != null) {
      refreshCache();
      updateMentorAPI(token, mentor.id!, jsonEncode(updates));
    }
  }

  Future<void> refreshCache() async {
    if (mentor.id != null) {
      CacheManager cache = CacheManager();
      await cache.addToCache("user", mentor.toJson());
    }
  }
}
