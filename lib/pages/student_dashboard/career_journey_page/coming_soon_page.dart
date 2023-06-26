import 'package:flutter/material.dart';

import '../../../utils/colours.dart';

class MentorComingSoonPage extends StatelessWidget {
  const MentorComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        backgroundColor: kPureWhite,
        foregroundColor: kPrimary,
        elevation: 1,
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            "Coming Soon",
            style: TextStyle(
              color: kGray,
              fontSize: 26,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
