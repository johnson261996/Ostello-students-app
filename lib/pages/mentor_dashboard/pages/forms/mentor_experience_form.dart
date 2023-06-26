import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import '../../mentor_signup_success_page.dart';

class MentorExperienceForm extends StatefulWidget {
  const MentorExperienceForm({Key? key}) : super(key: key);

  @override
  State<MentorExperienceForm> createState() => _MentorExperienceFormState();
}

class _MentorExperienceFormState extends State<MentorExperienceForm> {
  double _currentSliderValue = 3;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final mentorProvider = context.read<MentorProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Year of experience ",
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      "Please select the year of experience you have",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Slider(
                      max: 10,
                      divisions: 10,
                      value: _currentSliderValue,
                      label: "${_currentSliderValue.round()}+ years",
                      onChanged: (double value) {
                        setState(() => _currentSliderValue = value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "${_currentSliderValue.round()}+ years",
                        style: textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: Navigator.of(context).pop,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: DotsSlider(total: 8, current: 7),
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        mentorProvider.updateMentor(
                          "total_experience",
                          _currentSliderValue.round(),
                        );

                        mentorProvider.registerMentor().then((tokens) {
                          tokensProvider.setTokens = tokens;

                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: const MentorSignupSuccessPage(),
                            ),
                          );
                        });
                      },
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_forward_ios),
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
}

class CustomRadioChip extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;

  const CustomRadioChip({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onChanged(value),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: groupValue == value ? kPrimary : Colors.transparent,
                  border: Border.all(
                    color: groupValue == value
                        ? kPrimary
                        : const Color(0xff595E60),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Icon(
                  Icons.check,
                  color:
                      groupValue == value ? Colors.white : Colors.transparent,
                  size: 12,
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: text,
                    style: const TextStyle(
                      color: Color(0xff5A5A5A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
