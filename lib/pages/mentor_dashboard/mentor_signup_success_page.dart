import 'package:flutter/material.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/forms/mentor_type_selection.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../apis/mentor.dart';
import '../../providers/mentor_provider.dart';
import '../../utils/colours.dart';

class MentorSignupSuccessPage extends StatefulWidget {
  const MentorSignupSuccessPage({Key? key}): super(key: key);

  @override
  State<MentorSignupSuccessPage> createState() =>
      _MentorSignupSuccessPageState();
}

class _MentorSignupSuccessPageState extends State<MentorSignupSuccessPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kPrimary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/introductory/success_page/tick-circle.png",
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Account Created",
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your account has been created successfully",
                        style: textTheme.bodyMedium!.copyWith(
                          color: kWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          getMentorIDAPI(mentorProvider.mentor.phoneNumber!)
                              .then((id) {
                            mentorProvider.updateMentor("id", id);

                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: const MentorTypeSelection(),
                              ),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kWhite,
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: kPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
