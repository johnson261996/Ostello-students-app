import 'package:flutter/material.dart';

import '../apis/reviews.dart';
import '../models/review.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  set appendToReviews(List<Review> rvs) {
    _reviews.addAll(rvs);
    notifyListeners();
  }

  Future<void> getInstitutesReviews(String instituteid, [int limit = 3]) async {
    _reviews = await getInstituteReviews(instituteid, limit);
    notifyListeners();
  }
}
