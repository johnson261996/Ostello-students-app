import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './forms/name_form.dart';
import '../../../apis/mentor.dart';
import '../../../apis/otps.dart';
import '../../../apis/users.dart';
import '../../../models/mentor.dart';
import '../../../providers/chat_room_provider.dart';
import '../../../providers/mentor_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../providers/token_provider.dart';
import '../../../utils/cache.dart';
import '../../../utils/colours.dart';
import '../../error_pages/exception_raised_page.dart';
import '../../mentor_dashboard/pages/forms/mentor_name_form.dart';

class VerifyOTPPage extends StatefulWidget {
  final String phoneNumber;
  late bool forMentor;

  VerifyOTPPage({
    Key? key,
    this.forMentor = false,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  int _start = 30;
  bool _loading = false;
  bool _otpFilled = false;

  String _otp = "";
  Duration oneSec = const Duration(seconds: 1);

  late Timer _timer;
  late MentorProvider mentorProvider;
  late TokensProvider tokensProvider;
  late StudentProvider studentProvider;
  late ChatRoomProvider chatRoomProviderProvider;

  @override
  void initState() {
    restartTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    mentorProvider = context.read<MentorProvider>();
    tokensProvider = context.read<TokensProvider>();
    studentProvider = context.read<StudentProvider>();
    chatRoomProviderProvider = context.read<ChatRoomProvider>();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: Container(
          width: media.width,
          height: media.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                color: _loading ? kPrimary : kPureWhite,
                child: AnimatedOpacity(
                  opacity: _loading ? 1 : 0,
                  duration: const Duration(milliseconds: 800),
                  child: const LinearProgressIndicator(minHeight: 3),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify Phone Number",
                      style: textTheme.headlineLarge?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Please type the OTP sent to ${widget.phoneNumber}",
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _start < 10 ? "0$_start" : "$_start",
                          style: textTheme.bodySmall?.copyWith(
                            color: kGray,
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    OtpTextField(
                      fieldWidth: 50,
                      numberOfFields: 4,
                      showFieldAsBox: true,
                      borderColor: kLightPrimary,
                      keyboardType: TextInputType.number,
                      onSubmit: (code) => setState(
                        () => {
                          _otp = code,
                          _otpFilled = true,
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: media.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't receive any OTP?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: _start == 0
                                ? () async {
                                    await resendOtp(widget.phoneNumber);
                                    restartTimer();
                                  }
                                : null,
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: _start == 0 ? kBlue : kBodyTextColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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
                      color: kWhite,
                      iconSize: 20,
                      onPressed: Navigator.of(context).pop,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: _otpFilled
                        ? (_loading ? kLightGray : kPrimary)
                        : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed:
                          _otpFilled ? (_loading ? null : _onOtpSubmit) : null,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.check_rounded, size: 25),
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

  Future<void> _onOtpSubmit() async {
    setState(() {
      _loading = true;
    });

    CacheManager cache = CacheManager();

    final doesStudentExist = await userExistsAPI(widget.phoneNumber);
    final doesMentorExist = await mentorExistsAPI(widget.phoneNumber);

    try {
      if (doesStudentExist) {
        debugPrint("Student Account exists in DB!");

        final tokens = await loginAPI(widget.phoneNumber, _otp);
        await cache.addToCache("tokens", tokens.toJson());
        tokensProvider.setTokens = tokens;

        final st = await getStudentAPI(widget.phoneNumber);

        studentProvider.setStudent = st;
        studentProvider.setIsLoggedIn = true;

        String? hasViewedIntroCache = await cache.getFromCache("intro");
        studentProvider.setHasViewedIntro =
            hasViewedIntroCache == "true" ? true : false;

        await chatRoomProviderProvider.populateMessages(
          "ostelloai-${studentProvider.student.phoneNumber}",
          studentProvider.student.firstName!,
        );

        await cache.addToCache("user", st.toJson());
        await mentorProvider.getInitialMentors(tokens.accessToken);

        if (st.grade == null || st.schoolName == null) {
          return _navigateToHome("/user_details_questionnaire");
        } else {
          return _navigateToHome("/student_dashboard");
        }
      } else if (doesMentorExist) {
        debugPrint("Mentor Account exists in DB!");

        final tokens = await loginAPI(widget.phoneNumber, _otp);
        await cache.addToCache("tokens", tokens.toJson());
        tokensProvider.setTokens = tokens;

        Mentor mnt = await getMentorAPI(widget.phoneNumber);

        mentorProvider.setMentor = mnt;

        await cache.addToCache("user", mnt.toJson());
        return _navigateToHome("/mentor_subscription_status");
      } else {
        debugPrint("Account not found in DB!");

        bool verified = await verifyOtp(widget.phoneNumber, _otp);
        if (!verified) throw Exception("Incorrect OTP!");

        mentorProvider.updateMentor("phoneNumber", widget.phoneNumber);
        studentProvider.updateStudent("phoneNumber", widget.phoneNumber);
      }

      if (widget.forMentor) {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.fade,
            child: const MentorNameForm(),
          ),
        );
      } else {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.fade,
            child: const NameForm(),
          ),
        );
      }
    } on Exception catch (e) {
      Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ExceptionRaisedPage(error: e),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> restartTimer() async {
    _start = 30;

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> _navigateToHome(String path) async {
    await Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        Navigator.of(context).pushReplacementNamed(path);
      },
    );
  }
}
