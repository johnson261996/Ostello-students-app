import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../providers/student_provider.dart';
import '../../../../../utils/colours.dart';

class InviteAndEarnPage extends StatefulWidget {
  const InviteAndEarnPage({Key? key}) : super(key: key);

  @override
  State<InviteAndEarnPage> createState() => _InviteAndEarnPageState();
}

class _InviteAndEarnPageState extends State<InviteAndEarnPage> {
  @override
  Widget build(BuildContext context) {
    final studentProvider = context.watch<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        title: const Text(
          'Refer & Earn',
          style: TextStyle(
            fontSize: 24,
            color: kBlack,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: kPureWhite,
        foregroundColor: kPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset("assets/images/profile/poster.png"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 200,
                child: Text(
                  'Kill your fees by inviting Friends!',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: const TextSpan(
                  text: "Refer a friend and earn up to ",
                  style: TextStyle(
                    color: kBlack,
                  ),
                  children: [
                    TextSpan(
                      text: "Rs. 2000/-",
                      style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset('assets/images/profile/fist_bump.png'),
                    ),
                  ],
                ),
              ),
              if (studentProvider.wallet == null)
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Loading Wallet..."),
                    ],
                  ),
                )
              else
                Center(
                  child: SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () async => await Share.share(
                        "Hi! I trust *Ostello* to pay my institute's monthly fees, connect with mentors, and plan my career path.\n\nYou can win exciting rewards, a tuition scholarship for one month and a joining bonus of up to *₹2000/-& if you download Ostello using my *${studentProvider.wallet?.referralcode}* as my referral code within the next 48 hours.\n(App Link)",
                        subject: "Refer a Friend!",
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Refer Now",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.whatshot,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
