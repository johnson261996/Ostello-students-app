import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import './pages/session_brief.dart';
import './widgets/radio_buttons.dart';

class SessionSelector extends StatefulWidget {
  const SessionSelector({Key? key}) : super(key: key);

  @override
  State<SessionSelector> createState() => _SessionSelectorState();
}

class _SessionSelectorState extends State<SessionSelector> {
  int _selecteddate = 0;
  int _selectedtime = 0;
  int _selectedtype = 0;
  int _selectedstime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Pick a date',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 18,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                        color: Color(0xff1C4980),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: CustomRadioButton1(
                              value: 1,
                              groupValue: _selecteddate,
                              onChanged: (value) {
                                setState(() {
                                  _selecteddate = value;
                                });
                              },
                              text: 'May 5',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CustomRadioButton1(
                              value: 2,
                              groupValue: _selecteddate,
                              onChanged: (value) {
                                setState(() {
                                  _selecteddate = value;
                                });
                              },
                              text: 'May 6',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CustomRadioButton1(
                              value: 3,
                              groupValue: _selecteddate,
                              onChanged: (value) {
                                setState(() {
                                  _selecteddate = value;
                                });
                              },
                              text: 'May 7',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CustomRadioButton1(
                              value: 4,
                              groupValue: _selecteddate,
                              onChanged: (value) {
                                setState(() {
                                  _selecteddate = value;
                                });
                              },
                              text: 'May 8',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CustomRadioButton1(
                              value: 5,
                              groupValue: _selecteddate,
                              onChanged: (value) {
                                setState(() {
                                  _selecteddate = value;
                                });
                              },
                              text: 'May 9',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(0xff1C4980),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Pick a time',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 1,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 2,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 3,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 4,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 5,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRadioButton2(
                      value: 6,
                      groupValue: _selectedtime,
                      onChanged: (value) {
                        setState(() {
                          _selectedtime = value;
                        });
                      },
                      text: '11:00AM IST',
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Session Type',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CustomRadioButton3(
                        value: 1,
                        groupValue: _selectedtype,
                        onChanged: (value) {
                          setState(() {
                            _selectedtype = value;
                          });
                        },
                        text: 'Chat',
                        icon: FontAwesomeIcons.rocketchat,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRadioButton3(
                        value: 2,
                        groupValue: _selectedtype,
                        onChanged: (value) {
                          setState(() {
                            _selectedtype = value;
                          });
                        },
                        text: '1:1 Call',
                        icon: FontAwesomeIcons.phone,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Session Time',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CustomRadioButton4(
                        value: 1,
                        groupValue: _selectedstime,
                        onChanged: (value) {
                          setState(() {
                            _selectedstime = value;
                          });
                        },
                        text: '15 Mins',
                        icon: FontAwesomeIcons.clock,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRadioButton4(
                        value: 2,
                        groupValue: _selectedstime,
                        onChanged: (value) {
                          setState(() {
                            _selectedstime = value;
                          });
                        },
                        text: '30 Mins',
                        icon: FontAwesomeIcons.clock,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRadioButton4(
                        value: 3,
                        groupValue: _selectedstime,
                        onChanged: (value) {
                          setState(() {
                            _selectedstime = value;
                          });
                        },
                        text: '60 Mins',
                        icon: FontAwesomeIcons.clock,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: _selecteddate == 0 ||
                                      _selectedtime == 0 ||
                                      _selectedstime == 0 ||
                                      _selectedtype == 0
                                  ? const Color(0xff595E60)
                                  : const Color(0xff7D23E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SessionBriefPage()),
                              );

                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   // const SnackBar(
                              //   //   content: Text('Please Select an Option'),
                              //   //   duration: Duration(seconds: 2),
                              //   // ),
                              // );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Book Session',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            // style: MyTheme.buttonTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
