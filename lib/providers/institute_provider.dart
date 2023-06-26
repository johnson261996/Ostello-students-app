import 'package:flutter/material.dart';

import '../../apis/institutes.dart';
import '../models/institute.dart';

class InstituteProvider extends ChangeNotifier {
  List<Institute> _institutes = [];

  List<Institute> get institutes => _institutes;

  Future<void> getInstitutes(String query) async {
    _institutes = await getQueriedInstitutes(query);
    notifyListeners();
  }

// clearCache() {
//   CacheManager cache = CacheManager();
//   cache.clearCache();
// }

// refreshCache() async {
//   CacheManager cache = CacheManager();
//
//   await cache.addToCache("user", student.toJson());
//
//   Tokens tokens =
//       Tokens(accessToken: _accessToken!, refreshToken: _refreshToken!);
//
//   await cache.addToCache("tokens", tokens.toJson());
// }
}
