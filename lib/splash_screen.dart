import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './utils/colours.dart';
import '../apis/users.dart';
import '../models/mentor.dart';
import '../models/student.dart';
import '../models/token.dart';
import '../pages/error_pages/exception_raised_page.dart';
import '../providers/chat_room_provider.dart';
import '../providers/mentor_provider.dart';
import '../providers/student_provider.dart';
import '../providers/token_provider.dart';
import '../utils/cache.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _visible = false;
  bool _loading = false;
  bool _showError = false;
  bool _startInit = false;

  Color _color = kPrimary;

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);

      if (result == ConnectivityResult.none) {
        if (!_showError) {
          setState(() {
            _loading = false;
            _showError = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "No Network Found!",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: kPureWhite,
                    ),
              ),
            ),
          );
        }
      } else {
        if (!_startInit) {
          setState(() {
            _loading = true;
            _startInit = true;
          });

          initUser();
        }
      }
    });

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        _visible = true;
        _loading = true;
        _color = kPureWhite;
      }),
    );
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> initUser() async {
    MentorProvider mentorProvider = context.read<MentorProvider>();
    TokensProvider tokensProvider = context.read<TokensProvider>();
    StudentProvider studentProvider = context.read<StudentProvider>();
    ChatRoomProvider chatRoomProviderProvider =
        context.read<ChatRoomProvider>();

    CacheManager cache = CacheManager();

    try {
      String? userData = await cache.getFromCache("user");
      String? tokensData = await cache.getFromCache("tokens");

      if (userData != null && tokensData != null) {
        debugPrint("User and tokens found in cache!");

        Tokens tokens = Tokens.fromJson(json.decode(tokensData));

        final newTokens = await verifyAndRefreshTokensAPI(
          tokens.accessToken,
          tokens.refreshToken,
        );

        if (newTokens == false) {
          debugPrint("Tokens not verified!");

          _navigateToPage("/");
          return;
        }

        if (tokens.accessToken == newTokens.accessToken) {
          debugPrint("Tokens verified & Refreshed!");
        } else {
          debugPrint("Tokens verified!");
        }

        tokensProvider.setTokens = newTokens;

        final usertype = (json.decode(userData))["usertype"];

        if (usertype == 3) {
          debugPrint("Student Account!");

          Student st = Student.fromJson(json.decode(userData));

          mentorProvider.getInitialMentors(newTokens.accessToken);

          studentProvider.setStudent = st;
          studentProvider.setIsLoggedIn = true;

          String? hasViewedIntroCache = await cache.getFromCache("intro");
          studentProvider.setHasViewedIntro =
              hasViewedIntroCache == "true" ? true : false;

          studentProvider.refreshProfileStrength();
          await chatRoomProviderProvider.populateMessages(
            "ostelloai-${studentProvider.student.phoneNumber}",
            studentProvider.student.firstName!,
          );

          if (st.grade == null || st.schoolName == null) {
            _navigateToPage("/user_details_questionnaire");
          } else {
            _navigateToPage("/student_dashboard");
          }
        } else {
          debugPrint("Mentor Account: $usertype");

          Mentor mnt = Mentor.fromJson(json.decode(userData));
          mentorProvider.setMentor = mnt;

          _navigateToPage("/mentor_subscription_status");
        }
      } else {
        debugPrint("User or tokens not found in cache!");
        await tokensProvider.refreshTokens();

        _navigateToPage("/");
      }
    } on Exception catch (e) {
      Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.fade,
          child: ExceptionRaisedPage(error: e),
        ),
      );
    }
  }

  Future<void> _navigateToPage(String path) async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Navigator.of(context).pushReplacementNamed(path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPureWhite,
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              color: _loading ? kPureWhite : kPrimary,
              child: SafeArea(
                child: AnimatedOpacity(
                  opacity: _loading ? 1 : 0,
                  duration: const Duration(milliseconds: 800),
                  child: const LinearProgressIndicator(minHeight: 3),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: kPrimary,
                width: MediaQuery.of(context).size.width,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  opacity: _visible ? 1 : 0,
                  child: AnimatedContainer(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInBack,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: _visible
                            ? Alignment.topRight
                            : Alignment.bottomRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          _color,
                          kPureWhite,
                        ],
                      ),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: const Duration(seconds: 1),
                        constraints: BoxConstraints(
                          minHeight: 210,
                          maxHeight: _visible ? 210 : 240,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(150),
                              ),
                              child: Image.asset(
                                "assets/images/icons/logo.png",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Own Your Career!",
                              style: TextStyle(
                                fontSize: 24,
                                color: kPrimary,
                                fontFamily: "Gotham",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
