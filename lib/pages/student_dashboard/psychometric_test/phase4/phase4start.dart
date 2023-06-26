import 'package:flutter/material.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase1/phase1questions.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase4/phase4questions.dart';
import 'package:ostello_mentor/utils/colours.dart';
import 'package:page_transition/page_transition.dart';

class Phase4 extends StatefulWidget {
  const Phase4({Key? key}) : super(key: key);

  @override
  State<Phase4> createState() => _Phase4State();
}

class _Phase4State extends State<Phase4> {
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
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: kPrimary,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/test/phase4.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Text(
                  'This phase will unveil the activities,subjects and areas of knowledge the captivate your attention,'
                  'helping to align your interest with potential career paths and areas of personal growth.',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontWeight: FontWeight.normal,color: kGray,fontSize: 12, height: 1.5 ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
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
                                  child: const Phase4Que(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Start',
                                style: textTheme.headlineSmall
                                    ?.copyWith(color: kWhite),
                              ),
                            ),
                            // style: MyTheme.buttonTheme,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
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
