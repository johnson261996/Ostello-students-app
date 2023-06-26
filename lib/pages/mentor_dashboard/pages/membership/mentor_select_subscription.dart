import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/themes.dart';
import 'mentor_subscription_status_page.dart';

class MentorSelectSubscription extends StatefulWidget {
  const MentorSelectSubscription({Key? key}): super(key: key);

  @override
  State<MentorSelectSubscription> createState() =>
      _MentorSelectSubscriptionState();
}

class _MentorSelectSubscriptionState extends State<MentorSelectSubscription> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a plan that’s right for you ",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Container(
                            color: kPrimary,
                            width: double.infinity,
                            padding: const EdgeInsets.all(7),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ANNUAL',
                                  style: TextStyle(
                                    color: kPureWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: kPureWhite,
                              border: Border.all(
                                color: kPrimary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Rs. 1999',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    'MOST POPULAR',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    final url =
                        Uri.parse("https://ostello.co.in/mentor-payment");

                    launchUrl(url).then((launched) {
                      if (!launched) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error launching Payment Gateway!"),
                          ),
                        );
                      }
                    });

                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const MentorSubscriptionStatusPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Pay Now',
                    style: kButtonSecondaryStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
