import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_room_provider.dart';
import '../../providers/mentor_provider.dart';
import '../../providers/student_provider.dart';
import '../../providers/token_provider.dart';
import '../../utils/colours.dart';
import '../error_pages/exception_raised_page.dart';

class SignupSuccessPage extends StatefulWidget {
  const SignupSuccessPage({Key? key}): super(key: key);

  @override
  State<SignupSuccessPage> createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();
    final chatRoomProvider = context.read<ChatRoomProvider>();

    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: _loading ? 1 : 0,
              duration: const Duration(milliseconds: 800),
              child: const LinearProgressIndicator(
                minHeight: 3,
                color: kPureWhite,
                backgroundColor: kPrimary,
              ),
            ),
            Expanded(
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
                              setState(() {
                                _loading = true;
                              });

                              studentProvider.refreshProfileStrength();

                              chatRoomProvider
                                  .populateMessages(
                                "ostelloai-${studentProvider.student.phoneNumber}",
                                studentProvider.student.firstName!,
                              )
                                  .then((val) {
                                mentorProvider
                                    .getInitialMentors(
                                  tokensProvider.tokens!.accessToken,
                                )
                                    .then((val) {
                                  setState(() {
                                    _loading = false;
                                  });

                                  Navigator.of(context).pushReplacementNamed(
                                      "/user_details_questionnaire");
                                }).catchError((e) {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ExceptionRaisedPage(error: e),
                                    ),
                                  );
                                });
                              }).catchError((e) {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExceptionRaisedPage(error: e),
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
          ],
        ),
      ),
    );
  }
}
