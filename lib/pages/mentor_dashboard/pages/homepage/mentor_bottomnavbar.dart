import 'dart:io' show Platform, exit;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/homepage/pages/students_request.dart';

import '../../../../utils/colours.dart';
import '../../../student_dashboard/account_page/account_page.dart';
import '../../../student_dashboard/career_journey_page/career_journey_landing_page.dart';

class MentorBottomNavbarWrapper extends StatefulWidget {
  const MentorBottomNavbarWrapper({Key? key}) : super(key: key);

  @override
  State<MentorBottomNavbarWrapper> createState() => _WrapperState();
}

class _WrapperState extends State<MentorBottomNavbarWrapper> {
  int _idx = 0;
  bool _visible = true;
  final bool _canPop = false;
  late PageController _pageController;

  final List<Widget> _pages = const [
    StudentsRequest(),
    CareerJourneyLandingPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPureWhite,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;

          if (direction == ScrollDirection.reverse) {
            setState(() => _visible = false);
          } else if (direction == ScrollDirection.forward) {
            setState(() => _visible = true);
          }

          return true;
        },
        child: WillPopScope(
          onWillPop: () async {
            if (_canPop) {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }

              return true;
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Alert",
                    style: TextStyle(
                      fontSize: 28,
                      color: kBlack,
                      fontFamily: "Gotham",
                    ),
                  ),
                  content: const Text(
                    "Are you sure you want to exit?",
                    style: TextStyle(
                      color: kBlack,
                      fontFamily: "Roboto",
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );

              return false;
            }
          },
          child: PageView(
            controller: _pageController,
            onPageChanged: (idx) {
              setState(() {
                _idx = idx;
                _visible = true;
              });
            },
            children: _pages,
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: _visible ? 80 : 0,
        child: Stack(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: _idx == 1 ? kPrimary : kLightGray,
                shape: const CircleBorder(),
              ),
              onPressed: () {},
              child: const FaIcon(
                FontAwesomeIcons.route,
                semanticLabel: "home",
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: kRed,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "hh",
                    style: TextStyle(
                      color: kPureWhite,
                      fontFamily: "Roboto",
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: _visible ? 80 : 0,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: kWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _pageController.jumpToPage(0);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.house,
                  semanticLabel: "home",
                ),
                color: _idx == 0 ? kPrimary : kLightGray,
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  _pageController.jumpToPage(3);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.user,
                  semanticLabel: "profile",
                ),
                color: _idx == 2 ? kPrimary : kLightGray,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
