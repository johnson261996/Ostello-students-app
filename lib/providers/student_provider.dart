import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../apis/location.dart';
import '../apis/posts.dart';
import '../apis/users.dart';
import '../apis/wallet.dart';
import '../models/media_object.dart';
import '../models/post.dart';
import '../models/student.dart';
import '../models/wallet.dart';
import '../utils/cache.dart';
import '../utils/constants.dart';

class StudentProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _hasViewedIntro = false;

  int _activeIndex = 0;
  int _filledFields = 0;
  int _profileStrength = 0;
  int _profileStrengthFilledBlocks = 0;

  Wallet? _wallet;
  String? _referralCode;
  String? _chatQuickReply;
  Color? _profileStrengthColor;
  String? _profileStrengthCategory;

  late List<Post> _posts = [];

  Wallet? get wallet => _wallet;

  List<Post> get posts => _posts;

  String? get referralCode => _referralCode;

  final int _totalIndex = 2;
  final int _totalStudentDetailFields = 22;

  Student _student = Student.empty();

  set appendToPosts(List<Post> ps) {
    _posts.addAll(ps);
    notifyListeners();
  }

  set updatePosts(List<Post> ps) {
    _posts = ps;
    notifyListeners();
  }

  set setReferralCode(String refCode) {
    _referralCode = refCode;
  }

  set setStudent(Student st) {
    _student = st;
    refreshProfileStrength();
  }

  set setIsLoggedIn(bool val) {
    _isLoggedIn = val;
  }

  set setHasViewedIntro(bool val) {
    _hasViewedIntro = val;
    final cache = CacheManager();
    cache.addToCache("intro", hasViewedIntro.toString());
  }

  set setChatQuickReply(String chatQuickReply) {
    _chatQuickReply = chatQuickReply;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  bool get hasViewedIntro => _hasViewedIntro;

  String? get chatQuickReply => _chatQuickReply;

  Student get student => _student;

  int get totalIndex => _totalIndex;

  int get activeIndex => _activeIndex;

  int get profileStrength => _profileStrength;

  Color? get profileStrengthColor => _profileStrengthColor;

  String? get profileStrengthCategory => _profileStrengthCategory;

  int get profileStrengthFilledBlocks => _profileStrengthFilledBlocks;

  // Future<void> getInitialPosts() async {
  //   if (_accessToken == null) return;
  //
  //   _posts = await getPosts(_accessToken!, 10);
  //   notifyListeners();
  // }

  Future<void> getWalletDetails(String token, [bool refresh = false]) async {
    if (_wallet != null && !refresh) return;

    _wallet = await getWallet(token);
    notifyListeners();
  }

  Future<void> boostAPost(String token, String id) async {
    boostPostAPI(token, id);

    Post postToBeBoosted = _posts.firstWhere((post) => post.id == id);
    postToBeBoosted.liked = !postToBeBoosted.liked;
    postToBeBoosted.boosts = postToBeBoosted.liked
        ? postToBeBoosted.boosts + 1
        : postToBeBoosted.boosts - 1;

    notifyListeners();
  }

  Future<void> blockAUser(String token, String id) async {
    blockAUser(token, id);

    Post postToBeBlocked = _posts.firstWhere((post) => post.id == id);
    postToBeBlocked.blocked = !postToBeBlocked.blocked;

    notifyListeners();
  }

  void refreshProfileStrength() {
    _filledFields = 0;

    if (student.description != null) {
      _filledFields++;
    }

    if (student.email != null) {
      _filledFields++;
    }

    if (student.grade != null) {
      _filledFields++;
    }

    if (student.gender != null) {
      _filledFields++;
    }

    if (student.stream != null) {
      _filledFields++;
    }

    if (student.city != null) {
      _filledFields++;
    }

    if (student.ambition != null) {
      _filledFields++;
    }

    if (student.targetExam != null) {
      _filledFields++;
    }

    if (student.languageModeTeaching != null) {
      _filledFields++;
    }

    if (student.languageModeBooks != null) {
      _filledFields++;
    }

    if (student.currentInstitute != null) {
      _filledFields++;
    }

    if (student.coachingMode != null) {
      _filledFields++;
    }

    if (student.area != null) {
      _filledFields++;
    }

    if (student.state != null) {
      _filledFields++;
    }

    if (student.country != null) {
      _filledFields++;
    }

    if (student.pinCode != null) {
      _filledFields++;
    }

    if (student.lastName != null) {
      _filledFields++;
    }

    if (student.firstName != null) {
      _filledFields++;
    }

    if (student.schoolName != null) {
      _filledFields++;
    }

    if (student.dob != null) {
      _filledFields++;
    }

    if (student.phoneNumber != null) {
      _filledFields++;
    }

    if (student.streamDetail != null) {
      _filledFields++;
    }

    _profileStrength =
        ((_filledFields * 100) / _totalStudentDetailFields).round();

    if (_profileStrength > 0 && _profileStrength <= 20) {
      _profileStrengthCategory = "Poor";
      _profileStrengthFilledBlocks = 1;
      _profileStrengthColor = Colors.red.shade800;
    } else if (_profileStrength > 20 && _profileStrength <= 40) {
      _profileStrengthCategory = "Bad";
      _profileStrengthFilledBlocks = 2;
      _profileStrengthColor = Colors.red;
    } else if (_profileStrength > 40 && _profileStrength <= 60) {
      _profileStrengthCategory = "Intermediate";
      _profileStrengthFilledBlocks = 3;
      _profileStrengthColor = Colors.orange;
    } else if (_profileStrength > 60 && _profileStrength <= 80) {
      _profileStrengthCategory = "Good";
      _profileStrengthFilledBlocks = 4;
      _profileStrengthColor = Colors.green;
    } else if (_profileStrength > 80 && _profileStrength <= 100) {
      _profileStrengthCategory = "Excellent";
      _profileStrengthFilledBlocks = 5;
      _profileStrengthColor = Colors.green.shade800;
    }

    notifyListeners();
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

    updateStudent('area', area);
    updateStudent('city', areas[areasLen - 4]);
    updateStudent('state', areas[areasLen - 3]);
    updateStudent('country', areas[areasLen - 2]);
    updateStudent('pinCode', areas[areasLen - 1].toString());

    notifyListeners();
  }

  void logout() {
    CacheManager cache = CacheManager();
    cache.clearCache();

    _student = Student.empty();

    _isLoggedIn = false;
    _hasViewedIntro = false;

    _activeIndex = 0;
    _filledFields = 0;
    _profileStrength = 0;
    _profileStrengthFilledBlocks = 0;

    _wallet = null;
    _chatQuickReply = null;
    _profileStrengthColor = null;
    _profileStrengthCategory = null;

    notifyListeners();
  }

  Future<bool> loadFromCache() async {
    CacheManager cache = CacheManager();

    String? userData = await cache.getFromCache("user");

    if (userData != null) {
      Student st = Student.fromJson(json.decode(userData));

      _student = st;
      _isLoggedIn = true;

      String? hasViewedIntroCache = await cache.getFromCache("intro");
      _hasViewedIntro = hasViewedIntroCache == "true" ? true : false;

      return true;
    } else {
      return false;
    }
  }

  Future<void> refreshCache() async {
    CacheManager cache = CacheManager();

    if (student.id != null) {
      await cache.addToCache("user", student.toJson());
    }
  }

  void updateStudent(String key, String value, [String? token]) {
    Map<String, dynamic> updates = {};

    updates["location"] = {
      "country": student.country,
      "state": student.state,
      "city": student.city,
      "area": student.area,
      "pincode": student.pinCode,
    };

    if (key == 'avatar') {
      student.avatar = MediaObject(
        key: value,
        url: "$mediaHost/$value",
      );

      updates["avatar"] = {
        "key": value,
        "url": "$mediaHost/$value",
      };
    }

    if (key == 'id') {
      student.id = value;
    }

    if (key == 'firstName') {
      student.firstName = value;

      if (student.lastName != null) {
        updates["name"] = value + student.lastName!;
      } else {
        updates["name"] = value;
      }
    }

    if (key == 'lastName') {
      student.lastName = value;
      updates["name"] = student.lastName! + value;
    }

    if (key == 'description') {
      student.description = value;
      updates["description"] = value;
    }

    if (key == 'phoneNumber') {
      student.phoneNumber = value;
      updates["phonenumber"] = value;
    }

    if (key == 'email') {
      student.email = value;
      updates["email"] = value;
    }

    if (key == 'grade') {
      student.grade = value;
      updates["grade"] = value;
    }

    if (key == 'gender') {
      student.gender = value;
      updates["gender"] = value;
    }

    if (key == 'dob') {
      student.dob = value;
      updates["dob"] = value;
    }

    if (key == 'stream') {
      student.stream = value;
      updates["stream"] = value;
    }

    if (key == 'ambition') {
      student.ambition = value;
      updates["ambition"] = value;
    }

    if (key == 'targetExam') {
      student.targetExam = value;
      updates["targetexam"] = value;
    }

    if (key == 'languageModeTeaching') {
      student.languageModeTeaching = value;
      updates["languagemodeteaching"] = value;
    }

    if (key == 'languageModeBooks') {
      student.languageModeBooks = value;
      updates["languagemodebooks"] = value;
    }

    if (key == 'currentInstitute') {
      student.currentInstitute = value;
      updates["currentinstitute"] = value;
    }

    if (key == 'coachingMode') {
      student.coachingMode = value;
      updates["coachingmode"] = value;
    }

    if (key == 'schoolName') {
      student.schoolName = value;
      updates["schoolname"] = value;
    }

    if (key == 'city') {
      student.city = value;
      updates["location"]["city"] = value;
    }

    if (key == 'area') {
      student.area = value;
      updates["location"]["area"] = value;
    }

    if (key == 'state') {
      student.state = value;
      updates["location"]["state"] = value;
    }

    if (key == 'country') {
      student.country = value;
      updates["location"]["country"] = value;
    }

    if (key == 'pinCode') {
      student.pinCode = value;
      updates["location"]["pincode"] = value;
    }

    if (key == 'streamDetail') {
      student.streamDetail = value;
      updates["streamdetail"] = value;
    }

    refreshProfileStrength();
    notifyListeners();

    if (token != null) {
      refreshCache();
      updateUserAPI(student.id!, token, jsonEncode(updates));
    }
  }

  void forward() {
    if (_activeIndex < _totalIndex) {
      _activeIndex++;
      notifyListeners();
    }
  }

  void backward() {
    if (_activeIndex > 0) {
      _activeIndex--;
      notifyListeners();
    }
  }
}
