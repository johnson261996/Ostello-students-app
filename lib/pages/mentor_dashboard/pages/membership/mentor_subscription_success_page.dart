import 'package:flutter/material.dart';

class MentorSubscriptionSuccessPage extends StatefulWidget {
  const MentorSubscriptionSuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MentorSubscriptionSuccessPage> createState() =>
      _MentorSubscriptionSuccessPageState();
}

class _MentorSubscriptionSuccessPageState
    extends State<MentorSubscriptionSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 30),
              Text(
                "Thank You",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  fontFamily: "DMSans",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Your Mentor Subscription is Activated!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "DMSans",
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Please allow us 24 to 48 hours to verify your Account!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "DMSans",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
