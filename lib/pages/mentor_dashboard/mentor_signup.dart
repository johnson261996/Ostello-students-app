import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../apis/otps.dart';
import '../../utils/colours.dart';
import '../introductory/widgets/verify_otp.dart';

class MentorSignUp extends StatefulWidget {
  const MentorSignUp({Key? key}): super(key: key);

  @override
  State<MentorSignUp> createState() => _MentorSignUpState();
}

class _MentorSignUpState extends State<MentorSignUp> {
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        "Sign up as Mentor",
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Enter your Phone Number",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          _phoneNumber = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "9134xxxxxx",
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: Navigator.of(context).pop,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _phoneNumber != null && _phoneNumber!.length > 9
                            ? kPrimary
                            : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed:
                          _phoneNumber != null && _phoneNumber!.length == 10
                              ? () {
                                  generateOtp(_phoneNumber!).then((otpSent) {
                                    Navigator.of(context).push(
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: VerifyOTPPage(
                                          forMentor: true,
                                          phoneNumber: _phoneNumber!,
                                        ),
                                      ),
                                    );
                                  });
                                }
                              : null,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
