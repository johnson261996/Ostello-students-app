import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import './mentor_subscription_success_page.dart';
import '../../../../apis/mentor.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/themes.dart';

class MentorSubscriptionStatusPage extends StatefulWidget {
  const MentorSubscriptionStatusPage({Key? key}): super(key: key);

  @override
  State<MentorSubscriptionStatusPage> createState() =>
      _MentorSubscriptionStatusPageState();
}

class _MentorSubscriptionStatusPageState
    extends State<MentorSubscriptionStatusPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        "Check Subscription Status",
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Pending',
                              style: textTheme.headlineLarge!.copyWith(
                                color: kRed,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const CircularProgressIndicator(),
                            const SizedBox(height: 20),
                            Text(
                              'Waiting for Payment Confirmation',
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
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
                  },
                  child: const Text("Retry Payment!"),
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
                      getMentorAPI(mentorProvider.mentor.phoneNumber!)
                          .then((mentor) {
                        if (mentor.account_plan == "premium") {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const MentorSubscriptionSuccessPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Payment not yet completed!"),
                            ),
                          );
                        }
                      });
                    },
                    child: const Text(
                      'Check Status',
                      style: kButtonSecondaryStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
