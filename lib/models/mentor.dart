import 'dart:convert';

import "./comment.dart";
import './media_object.dart';

class Mentor {
  String? id;
  String? name;
  String? username;
  String? email;
  String? phoneNumber;
  String? dob;
  String? shortbio;
  String? description;

  bool followed = false;

  int approval = 4;
  int reviews_count = 0;
  int followers_count = 0;
  int total_experience = 0;

  String? field;
  String? specialization;
  String? linkedin;
  String? audience;
  String? account_plan;

  dynamic account_plan_details;

  List<String> interests = [];
  List<String> expertises = [];

  MediaObject? avatar;
  List<MentorExperience> experience = [];
  List<MentorEducation> education = [];
  List<MentorAvailability> availability = [];

  String? country;
  String? state;
  String? city;
  String? area;
  String? pinCode;

  Mentor.empty();

  Mentor({
    this.id,
    this.name,
    this.email,
    this.dob,
    this.avatar,
    this.field,
    this.username,
    this.linkedin,
    this.shortbio,
    required this.audience,
    this.phoneNumber,
    this.description,
    this.specialization,
    this.account_plan,
    this.account_plan_details,
    required this.approval,
    required this.followed,
    required this.total_experience,
    required this.reviews_count,
    required this.followers_count,
    required this.interests,
    required this.expertises,
    required this.experience,
    required this.availability,
  });

  static parseInterests(dynamic dynamicInterests) {
    List<String> stringInterests = [];

    if (dynamicInterests == null) return [];

    for (int i = 0; i < dynamicInterests.length; i++) {
      stringInterests.add(dynamicInterests[i].toString());
    }

    return stringInterests;
  }

  static parseComments(List jsonComments) {
    List<Comment> tempComments = [];

    for (int i = 0; i < jsonComments.length; i++) {
      tempComments.add(Comment.fromJson(jsonComments[i]));
    }

    return tempComments;
  }

  static parseExperience(List experiences) {
    List<MentorExperience> tempExperiences = [];

    for (int i = 0; i < experiences.length; i++) {
      tempExperiences.add(MentorExperience.fromJson(experiences[i]));
    }

    return tempExperiences;
  }

  static parseAvailability(List availabilities) {
    List<MentorAvailability> tempAvailabilities = [];

    for (int i = 0; i < availabilities.length; i++) {
      tempAvailabilities.add(MentorAvailability.fromJson(availabilities[i]));
    }

    return tempAvailabilities;
  }

  List<String> encodeExperiences() {
    List<String> experiences = [];

    for (final exp in experience) {
      experiences.add(exp.toJson());
    }

    return experiences;
  }

  List<String> encodeAvailability() {
    List<String> availabilities = [];

    for (final avb in availability) {
      availabilities.add(avb.toJson());
    }

    return availabilities;
  }

  static fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      dob: json["dob"],
      username: json["username"],
      phoneNumber: json["phonenumber"],
      shortbio: json["shortbio"],
      description: json["description"],
      total_experience: json["total_experience"],
      reviews_count: json["reviews_count"] ?? 0,
      followed: json["followed"] ?? false,
      followers_count: json["followers_count"] ?? 0,
      field: json["field"],
      specialization: json["specialization"],
      linkedin: json["linkedin"],
      approval: json["approval"] ?? 4,
      account_plan: json["account_plan"],
      audience: json["audience"],
      account_plan_details: json["account_plan_details"],
      experience:
          json["experience"] != null ? parseExperience(json["experience"]) : [],
      availability: json["availability"] != null
          ? parseAvailability(json["availability"])
          : [],
      interests:
          json["interests"] != null ? parseInterests(json["interests"]) : [],
      expertises:
          json["expertises"] != null ? parseInterests(json["expertises"]) : [],
      avatar: json["avatar"] != null
          ? (json["avatar"].runtimeType == String
              ? MediaObject.fromJson(jsonDecode(json["avatar"]))
              : MediaObject.fromJson(json["avatar"]))
          : null,
    );
  }

  String toJson() {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "dob": dob,
      "shortbio": shortbio,
      "username": username,
      "phonenumber": phoneNumber,
      "total_experience": total_experience,
    };

    if (description != null) {
      data["description"] = description;
    }

    if (field != null) {
      data["field"] = field;
    }

    if (linkedin != null) {
      data["linkedin"] = linkedin;
    }

    if (audience != null) {
      data["audience"] = audience;
    }

    if (account_plan != null) {
      data["account_plan"] = account_plan;
    }

    if (account_plan_details != null) {
      data["account_plan_details"] = account_plan_details;
    }

    if (avatar != null) {
      data["avatar"] = avatar;
    }

    if (specialization != null) {
      data["specialization"] = specialization;
    }

    if (experience.isNotEmpty) {
      data["experience"] = experience;
    }

    if (availability.isNotEmpty) {
      data["availability"] = availability;
    }

    if (interests.isNotEmpty) {
      data["interests"] = interests;
    }

    if (expertises.isNotEmpty) {
      data["expertises"] = expertises;
    }

    return json.encode(data);
  }
}

class MentorEducation {
  String school;
  String degree;
  String period;
  String grade;
  String fieldOfStudy;
  String? description;
  List<String> skills = [];
  String? activitiesAndSocieties;
  MediaObject? logo;

  MentorEducation({
    required this.school,
    required this.degree,
    required this.period,
    required this.grade,
    required this.fieldOfStudy,
    required this.skills,
    this.description,
    this.activitiesAndSocieties,
    this.logo,
  });

  static fromJson(Map<String, dynamic> json) {
    return MentorEducation(
      school: json["school"],
      degree: json["degree"],
      period: json["period"],
      grade: json["grade"],
      skills: json["skills"],
      fieldOfStudy: json["fieldOfStudy"],
      description: json["description"],
      activitiesAndSocieties: json["activitiesAndSocieties"],
      logo: json["logo"] != null ? MediaObject.fromJson(json["logo"]) : null,
    );
  }

  String toJson() {
    return json.encode({
      "school": school,
      "degree": degree,
      "description": description,
      "period": period,
      "grade": grade,
      "skills": skills,
      "fieldOfStudy": school,
      "activitiesAndSocieties": activitiesAndSocieties,
      "logo": logo?.toJson(),
    });
  }
}

class MentorAvailability {
  String date;
  String timeslot;

  MentorAvailability({
    required this.date,
    required this.timeslot,
  });

  static fromJson(Map<String, dynamic> json) {
    return MentorAvailability(
      date: json["date"],
      timeslot: json["timeslot"],
    );
  }

  String toJson() {
    return json.encode({
      "date": date,
      "timeslot": timeslot,
    });
  }
}

class MentorExperience {
  String name;
  String title;
  String position;
  MediaObject? logo;
  String period;
  String company;
  String location;
  String industry;
  String? description;

  MentorExperience({
    required this.name,
    required this.position,
    this.logo,
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.industry,
    required this.description,
  });

  static fromJson(Map<String, dynamic> json) {
    return MentorExperience(
      name: json["name"],
      period: json["period"],
      position: json["position"],
      logo: json["logo"] != null ? MediaObject.fromJson(json["logo"]) : null,
      title: json["title"],
      company: json["company"],
      location: json["location"],
      industry: json["industry"],
      description: json["description"],
    );
  }

  String toJson() {
    return json.encode({
      "name": name,
      "period": period,
      "position": position,
      "logo": logo?.toJson(),
      "title": title,
      "company": company,
      "location": location,
      "industry": industry,
      "description": description
    });
  }
}
