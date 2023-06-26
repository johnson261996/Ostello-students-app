import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import './career_journey_page.dart';
import './widgets/mentor_finding.dart';
import '../../../providers/student_provider.dart';
import '../../../utils/colours.dart';

class CareerJourneyLandingPage extends StatelessWidget {
  const CareerJourneyLandingPage({Key? key}) : super(key: key);

  void navigateBack(StudentProvider studentProvider, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builder) => const CareerJourneyPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 24,
              right: 24,
              bottom: 64,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  kPrimary,
                  Color(0xFFFFAB10),
                ],
              ),
            ),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 680,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: kWhite),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: kWhite,
                    padding: const EdgeInsets.symmetric(
                      vertical: 35,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: 'INDIA’s First ',
                              style: TextStyle(
                                fontSize: 20,
                                color: kBlack,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'REAL-TIME',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kPrimary,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Career Management Platform',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: kBlack,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: 'From ',
                            style: TextStyle(
                              fontSize: 16,
                              color: kBlack,
                              fontFamily: "DMSans",
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Exam Selection',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' to '),
                              TextSpan(
                                text: 'Career Selection',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' And Everything in Between'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () =>
                              navigateBack(studentProvider, context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(width: 1, color: kGray),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: const Text(
                            "Create your Career Journey",
                            style: TextStyle(
                              fontSize: 14,
                              color: kBlack,
                              fontFamily: "DMSans",
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/mentor/mentor_landing_hero.png',
                      width: 500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "How can Ostello help you?",
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimary,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "01",
                        style: TextStyle(
                          fontSize: 16,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Create your Career Plan",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Ready to launch your career?\nIn less 60 seconds identify your interests, research potential careers, network with professionals, gain experience",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "DMSans",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "02",
                        style: TextStyle(
                          fontSize: 16,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Keep a Track",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "With Ostello's AI, you can confidently track your career, get personalized mentor support, stay up-to-date on education trends, and achieve your dream career goals.",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "DMSans",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "03",
                        style: TextStyle(
                          fontSize: 16,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Get Recommendations",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Let Ostello help you achieve your career goals by recommending personalized suggestions based on the path you choose. ",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "DMSans",
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
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Find your mentor in just",
                  style: TextStyle(
                    fontSize: 20,
                    color: kPrimary,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: const [
                    Text(
                      "120 seconds",
                      style: TextStyle(
                        fontSize: 26,
                        color: kPrimary,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "(Coming Soon...)",
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimary,
                        fontFamily: "DMSans",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const FindingMentorAnimationWidget(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Text(
              "Your career is our main Priority",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: kBlack,
                fontFamily: "DMSans",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'and we are proud you are an ',
                style: TextStyle(
                  fontSize: 12,
                  color: kBlack,
                  fontFamily: "DMSans",
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'OSTELLian',
                    style: TextStyle(
                      color: kPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
