import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 140,
            height: 140,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
            ),
            child: SvgPicture.asset(
              "assets/images/mentor/mentor_placeholder.svg",
            ),
          ),
        ),
        const Text(
          "Himank Airon",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: "DMSans",
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Product Manager at Microsoft",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "DMSans",
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
        const Icon(
          Icons.check_circle_rounded,
          size: 100,
          color: Colors.green,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const Text(
          "You has been successfully booked",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "DMSans",
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed("/student_dashboard");
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
                              "Back to home page",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto",
                                fontSize: 16,
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
    )));
  }
}
