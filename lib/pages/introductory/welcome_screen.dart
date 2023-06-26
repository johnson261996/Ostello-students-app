import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_content.dart';
import '../../utils/colours.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: index == contents.length - 1
                              ? const SizedBox(height: 14)
                              : GestureDetector(
                                  onTap: () => _controller.jumpToPage(2),
                                  child: const Text(
                                    'Skip',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Image.asset(contents[index].image),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      contents[index].text,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      contents[index].highlightedText,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Roboto',
                                        color: kPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    contents[index].description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: kGray,
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () => index == contents.length - 1
                                      ? Navigator.of(context)
                                          .pushReplacementNamed("/getstarted")
                                      : _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(140, 40),
                                    ),
                                  ),
                                  child: index == contents.length - 1
                                      ? const Text(
                                          'Get Started',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        )
                                      : const Text(
                                          'Next',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 10)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: 10,
                margin: const EdgeInsets.only(bottom: 10),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: contents.length,
                  effect: const WormEffect(
                    radius: 5,
                    dotWidth: 5,
                    dotHeight: 5,
                    activeDotColor: kPrimary,
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
