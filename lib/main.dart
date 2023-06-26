import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/homepage/mentor_bottomnavbar.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/test_mainpage.dart';
import 'package:ostello_mentor/providers/test_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './pages/bottomnavbar_wrapper.dart';
import './pages/introductory/getstarted.dart';
import './pages/introductory/success_page.dart';
import './pages/introductory/welcome_screen.dart';
import './pages/mentor_dashboard/mentor_signup.dart';
import './pages/mentor_dashboard/pages/membership/mentor_subscription_status_page.dart';
import './pages/student_dashboard/user_questionnaire/user_details_questionnaire.dart';
import './providers/chat_room_provider.dart';
import './providers/institute_provider.dart';
import './providers/mentor_provider.dart';
import './providers/review_provider.dart';
import './providers/school_provider.dart';
import './providers/student_provider.dart';
import './providers/token_provider.dart';
import './splash_screen.dart';
import './utils/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => SchoolProvider()),
        ChangeNotifierProvider(create: (_) => TokensProvider()),
        ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
        ChangeNotifierProvider(create: (_) => InstituteProvider()),
        ChangeNotifierProvider(create: (_) => MentorProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => TestProvider()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        initialRoute: "/test_page",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/splash':
              return PageTransition(
                child: const SplashScreen(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/':
              return PageTransition(
                child: const WelcomeScreen(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/getstarted':
              return PageTransition(
                child: const GetStartedPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/user_details_questionnaire':
              return PageTransition(
                child: const UserDetailsQuestionnaire(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/success':
              return PageTransition(
                child: const SignupSuccessPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/student_dashboard':
              return PageTransition(
                child: const BottomNavbarWrapper(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/mentor_signup':
              return PageTransition(
                child: const MentorSignUp(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/mentor_subscription_status':
              return PageTransition(
                child: const MentorSubscriptionStatusPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );

            // TODO: Update the Widget!
            // case '/mentor_dashboard':
            //   return PageTransition(
            //     child: const MentorSignUp(),
            //     type: PageTransitionType.rightToLeftWithFade,
            //   );

            case '/mentor_home':
              return PageTransition(
                child: const MentorBottomNavbarWrapper(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/test_page':
              return PageTransition(
                child: const TestMainpage(),
                type: PageTransitionType.rightToLeftWithFade,
              );

            default:
              return null;
          }
        },
      ),
    );
  }
}
