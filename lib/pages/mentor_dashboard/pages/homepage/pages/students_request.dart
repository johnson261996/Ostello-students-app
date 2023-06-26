import 'package:flutter/material.dart';

import '../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';

class StudentsRequest extends StatefulWidget {
  const StudentsRequest({Key? key}) : super(key: key);

  @override
  State<StudentsRequest> createState() => _StudentsRequestState();
}

class _StudentsRequestState extends State<StudentsRequest> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Requests',
                      style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Helping Assistants',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: kGray,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: kGray.withOpacity(0.5),
              thickness: 0.5,
            ),
            const SizedBox(height: 15),
            Container(
              height: 55,
              margin: const EdgeInsets.only(left: 40.0, right: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: const Color(0xffB6B6B6).withOpacity(0.6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.36,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                      color: _selectedIndex == 0
                          ? const Color(0xffE4D1F8)
                          : Colors.white,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                      child: Text(
                        'Active Requests',
                        style: kButtonPrimaryStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _selectedIndex == 0 ? kPrimary : kGray,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.36,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: _selectedIndex == 1
                          ? const Color(0xffE4D1F8)
                          : Colors.white,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 1;
                        });
                      },
                      child: Text(
                        'Previous Requests',
                        style: kButtonPrimaryStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _selectedIndex == 0 ? kGray : kPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _selectedIndex == 0
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: const Color(0xffB6B6B6).withOpacity(0.6),
                          ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.0,
                              height: 120.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/mentor/aditya.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Aditya Nathan',
                                          style: kButtonPrimaryStyle.copyWith(
                                              fontSize: 16)),
                                      Text(
                                        '12:24 PM',
                                        style: kBodyTextStyle.copyWith(
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Class - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '11',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Stream - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Medical (PCB)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Area - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Chawla nagar',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            // Accept button pressed
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: kPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Accept',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      SizedBox(
                                        height: 40,
                                        width: 100,
                                        child: TextButton(
                                          onPressed: () {
                                            // Accept button pressed
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: kWhite,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Decline',
                                            style: TextStyle(
                                              color: kBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: const Color(0xffB6B6B6).withOpacity(0.6),
                          ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.0,
                              height: 120.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/mentor/aditya.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Aditya Nathan',
                                          style: kButtonPrimaryStyle.copyWith(
                                              fontSize: 16)),
                                      Text(
                                        '2 weeks ago',
                                        style: kBodyTextStyle.copyWith(
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Class - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '11',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Stream - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Medical (PCB)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      text: 'Area - ',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w900),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Chawla nagar',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 220,
                                        height: 40,
                                        child: TextButton(
                                          onPressed: () {
                                            // Accept button pressed
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: kPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'View Chat',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
          ],
        ),
      ),
    );
  }
}
