import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import './thank_you.dart';

class SessionBriefPage extends StatefulWidget {
  const SessionBriefPage({Key? key}) : super(key: key);

  @override
  State<SessionBriefPage> createState() => _SessionBriefPageState();
}

class _SessionBriefPageState extends State<SessionBriefPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 7),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: 'Session Brief',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    text: 'Please verify your session details ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Roboto",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xffFFF7E0),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: const Color(0xffFFC11D),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Session',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "DMsans",
                        ),
                      ),
                    ),
                    const Text(
                      '60 Minutes Mentor meet',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "DMsans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.phone,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1:1 Call',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "DMsans",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '60 Mins',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "DMsans",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '₹499',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "DMsans"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        Chip(
                          label: const Text('Product Consulting'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: "DMsans",
                              fontSize: 12),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(
                              color: Color(0xffFFC11D),
                              width: 1,
                            ),
                          ),
                        ),
                        Chip(
                          label: const Text('Ui/Ux & Design'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: "DMsans",
                              fontSize: 12),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(
                              color: Color(0xffFFC11D),
                              width: 1,
                            ),
                          ),
                        ),
                        Chip(
                          label: const Text('Fianance'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: "DMsans",
                              fontSize: 12),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(
                              color: Color(0xffFFC11D),
                              width: 1,
                            ),
                          ),
                        ),
                        Chip(
                          label: const Text('Mobile App Developement'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: "DMsans",
                              fontSize: 12),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(
                              color: Color(0xffFFC11D),
                              width: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0, left: 15),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff54769F),
                    fontFamily: "DMsans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 15),
                child: Text(
                  '1:1 mentorship session for personalized, hands-on and practical guidance.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff54769F),
                    fontFamily: "DMsans",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const ThankYouPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(125, 35, 224, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Proceed",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
