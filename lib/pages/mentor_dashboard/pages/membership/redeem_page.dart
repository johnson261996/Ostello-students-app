import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import './mentor_subscription_success_page.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/themes.dart';

class RedeemMentorCodePage extends StatefulWidget {
  const RedeemMentorCodePage({Key? key}): super(key: key);

  @override
  State<RedeemMentorCodePage> createState() => _RedeemMentorCodePageState();
}

class _RedeemMentorCodePageState extends State<RedeemMentorCodePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                            Navigator.of(context).pop();
                          },
                        ),
                      )),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          "Redeem Code",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontFamily: 'DM Sans'),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Verify the code & get access to app",
                        style: TextStyle(
                          color: kGray,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter the Membership code here",
                          hintStyle: const TextStyle(fontSize: 15),
                          contentPadding: const EdgeInsets.all(25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff7D23E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const MentorSubscriptionSuccessPage(),
                              ),
                            ),
                            child: RichText(
                              text: const TextSpan(
                                text: 'Confirm',
                                style: kButtonSecondaryStyle,
                              ),
                            ),
                            // style: MyTheme.buttonTheme,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
