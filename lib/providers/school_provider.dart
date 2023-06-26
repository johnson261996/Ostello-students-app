import 'package:flutter/material.dart';

import '../apis/schools.dart';
import '../models/school.dart';

class SchoolProvider extends ChangeNotifier {
  List<School> _schools = [];

  List<School> get schools => _schools;

  set appendToSchools(List<School> tempSchools) {
    _schools.addAll(tempSchools);
    notifyListeners();
  }

  Future<void> getInitialSchools([String keyword = ""]) async {
    final schools = await getAllSchoolsAPI(30, keyword);

    _schools = schools;
    notifyListeners();
  }

  Future<bool> listInstitute(
    String token,
    String name,
    String area,
    int pinCode,
  ) async {
    dynamic body = {
      "School Name": name,
      "Address": "$area - $pinCode",
    };

    bool listed = await listSchoolAPI(token, body);
    if (listed) getInitialSchools();

    notifyListeners();
    return listed;
  }
}
