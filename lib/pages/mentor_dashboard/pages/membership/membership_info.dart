import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import './mentor_select_subscription.dart';
import './redeem_page.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/themes.dart';

class MembershipInfo extends StatefulWidget {
  const MembershipInfo({Key? key}): super(key: key);

  @override
  State<MembershipInfo> createState() => _MembershipInfoState();
}

class _MembershipInfoState extends State<MembershipInfo> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                        "Unlock your membership",
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Access and inspire 15,000 students in one powerful network",
                        style: textTheme.bodyMedium!.copyWith(
                          color: kGray,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0;
                              i < kMembershipInfoContent.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          kMembershipInfoContent[i]
                                              ["imagePath"],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Text(
                                      kMembershipInfoContent[i]["content"],
                                      style: textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
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
                        child: const MentorSelectSubscription(),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: kButtonSecondaryStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have a Membership Code?',
                      style: textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const RedeemMentorCodePage(),
                        ),
                      ),
                      child: Text(
                        ' Redeem it now',
                        style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
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
