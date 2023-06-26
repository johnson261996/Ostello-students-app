import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/themes.dart';
import '../../widgets/custom_radio_chip.dart';
import '../../widgets/dot_slider.dart';
import 'school_form_page_3.dart';

class SchoolFormPage2 extends StatefulWidget {
  const SchoolFormPage2({Key? key}) : super(key: key);

  @override
  State<SchoolFormPage2> createState() => _SchoolFormPage2State();
}

class _SchoolFormPage2State extends State<SchoolFormPage2> {
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Please select your ',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: 'Grade',
                      style: kLargeBoldTextStyle,
                    ),
                    TextSpan(
                      text: ' from options below',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: kClasses.length,
                    itemBuilder: (ctx, idx) => CustomRadioChip(
                      value: idx,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                      text: kClasses[idx],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
                    child: DotsSlider(total: 4, current: 2),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedOption != -1 ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedOption != -1
                          ? () {
                              studentProvider.updateStudent(
                                "grade",
                                kClasses[_selectedOption],
                                tokensProvider.tokens!.accessToken,
                              );

                              if (_selectedOption > 9) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const SchoolFormPage3(),
                                  ),
                                );
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed('/student_dashboard');
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
