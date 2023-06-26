import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase1/phase1start.dart';
import 'package:ostello_mentor/utils/colours.dart';
import 'package:ostello_mentor/utils/themes.dart';
import 'package:page_transition/page_transition.dart';

class TestMainpage extends StatefulWidget {
  const TestMainpage({Key? key}) : super(key: key);

  _TestMainpageState createState() => _TestMainpageState();
}

class _TestMainpageState extends State<TestMainpage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: kPrimary,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                    // const Align(
                    //     alignment: Alignment.topRight,
                    //     child: Text(
                    //       "Skip",
                    //       style: TextStyle(
                    //         fontSize: 18.0,
                    //         fontWeight: FontWeight.w400,
                    //         color: Color(0xff5A5A5A),
                    //         fontFamily: 'DM Sans',
                    //       ),
                    //     )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 380,
                    height: 330,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/test/starttest.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Text(
                  "Psychometric Test",
                  style: textTheme.headlineLarge?.copyWith(
                      color: kBlack, fontFamily: 'Roboto', fontSize: 30),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 45),
                  child: Text(
                    "Unlocking the secrets of personality & explore your inner self ",
                    style: textTheme.bodySmall?.copyWith(color: kGray),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const Phase1(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Take Test',
                                style: textTheme.headlineSmall
                                    ?.copyWith(color: kWhite),
                              ),
                            ),
                            // style: MyTheme.buttonTheme,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.language,
                                color: Color(0xff3959FF),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                "Change Language",
                                style: kButtonPrimaryStyle.copyWith(
                                  color: Color(0xff3959FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
