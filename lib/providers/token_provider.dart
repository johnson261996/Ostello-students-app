import 'package:flutter/material.dart';

import '../apis/users.dart';
import '../models/token.dart';
import '../utils/cache.dart';

class TokensProvider extends ChangeNotifier {
  Tokens? _tokens;

  Tokens? get tokens => _tokens;

  set setTokens(Tokens tokens) {
    _tokens = tokens;

    notifyListeners();
    refreshTokenCache();
  }

  Future<void> refreshTokenCache() async {
    CacheManager cache = CacheManager();

    if (_tokens != null) {
      Tokens tns = Tokens(
        accessToken: _tokens!.accessToken,
        refreshToken: _tokens!.refreshToken,
      );

      await cache.addToCache("tokens", tns.toJson());
    }
  }

  Future<void> refreshTokens() async {
    if (_tokens != null) {
      Tokens newTokens = await verifyAndRefreshTokensAPI(
        _tokens!.accessToken,
        _tokens!.refreshToken,
      );

      _tokens = newTokens;
      notifyListeners();
    }
  }
}
