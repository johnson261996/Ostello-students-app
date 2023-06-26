import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";
import "package:provider/provider.dart";

import "./pages/college_form_pages/college_form_page_1.dart";
import './pages/parent_form_screens/parent_form_page.dart';
import './pages/school_form_screens/school_form_page_1.dart';
import './widgets/custom_radio_button.dart';
import './widgets/dot_slider.dart';
import "../../../providers/school_provider.dart";
import "../../../providers/student_provider.dart";
import "../../../utils/colours.dart";
import "../../../utils/constants.dart";
import "../../../utils/themes.dart";

class UserDetailsQuestionnaire extends StatefulWidget {
  const UserDetailsQuestionnaire({Key? key}) : super(key: key);

  @override
  State<UserDetailsQuestionnaire> createState() =>
      _UserDetailsQuestionnaireState();
}

class _UserDetailsQuestionnaireState extends State<UserDetailsQuestionnaire> {
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    final schoolProvider = context.read<SchoolProvider>();
    final studentProvider = context.watch<StudentProvider>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kPureWhite,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hey ',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '${studentProvider.student.firstName}',
                      style: kLargeBoldTextStyle,
                    ),
                    TextSpan(
                      text:
                          ',\nnice to meet you! How about we get to know each other better?',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                text: const TextSpan(
                  text: 'Which describes you best?',
                  style: kBodyTextStyle,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (ctx, idx) => const SizedBox(height: 20),
                  itemCount: kUserTypes.length,
                  itemBuilder: (ctx, idx) => CustomRadioButton(
                    value: idx,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                    text: kUserTypes[idx],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Opacity(
                    opacity: 0,
                    child: CircleAvatar(
                      backgroundColor: kLightGray,
                      radius: 30,
                      child: IconButton(
                        onPressed: null,
                        color: kWhite,
                        iconSize: 20,
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: DotsSlider(total: 3, current: 0),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedOption != -1 ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedOption != -1
                          ? () {
                              schoolProvider.getInitialSchools();

                              if (_selectedOption == 0) {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const SchoolFormPage1(),
                                  ),
                                );
                              } else if (_selectedOption == 1) {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const CollegeFormPage1(),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const ParentFormPage(),
                                  ),
                                );
                              }
                            }
                          : null,
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
