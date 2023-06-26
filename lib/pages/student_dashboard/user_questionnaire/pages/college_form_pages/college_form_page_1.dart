import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './college_form_page_2.dart';
import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/themes.dart';
import '../../widgets/custom_radio_chip.dart';
import '../../widgets/dot_slider.dart';

class CollegeFormPage1 extends StatefulWidget {
  const CollegeFormPage1({Key? key}) : super(key: key);

  @override
  State<CollegeFormPage1> createState() => _CollegeFormPage1State();
}

class _CollegeFormPage1State extends State<CollegeFormPage1> {
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
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Please let us know your ',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: 'Current Education',
                      style: kLargeBoldTextStyle,
                    ),
                    TextSpan(
                      text: ' level',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                  itemCount: kEducationLevels.length,
                  separatorBuilder: (ctx, idx) => const SizedBox(height: 10),
                  itemBuilder: (ctx, idx) => CustomRadioChip(
                    value: idx,
                    groupValue: _selectedOption,
                    text: kEducationLevels[idx],
                    onChanged: (val) {
                      setState(() => _selectedOption = val);
                    },
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
                    child: DotsSlider(total: 3, current: 1),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedOption != -1 ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedOption != -1
                          ? () {
                              if (_selectedOption != -1) {
                                studentProvider.updateStudent(
                                  "grade",
                                  kEducationLevels[_selectedOption],
                                  tokensProvider.tokens!.accessToken,
                                );

                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const CollegeFormPage2(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Select an Option'),
                                    duration: Duration(seconds: 2),
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
