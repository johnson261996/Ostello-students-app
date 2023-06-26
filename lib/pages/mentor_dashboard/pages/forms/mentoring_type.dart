import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../student_dashboard/user_questionnaire/widgets/custom_radio_button.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import 'mentor_expertise_form.dart';

class MentoringType extends StatefulWidget {
  const MentoringType({Key? key}): super(key: key);

  @override
  State<MentoringType> createState() => _MentoringTypeState();
}

class _MentoringTypeState extends State<MentoringType> {
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final mentorProvider = context.read<MentorProvider>();
    final tokensProvider = context.read<TokensProvider>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Who do you want to mentor?",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontFamily: 'DM Sans'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: kAudience.length,
                  separatorBuilder: (ctx, idx) => const SizedBox(height: 10),
                  itemBuilder: (ctx, idx) => CustomRadioButton(
                    value: idx,
                    groupValue: _selectedOption,
                    text: kAudience[idx],
                    onChanged: (_) {
                      setState(() => _selectedOption = idx);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
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
                          onPressed: () {
                            if (_selectedOption != -1) {
                              mentorProvider.updateMentor(
                                "audience",
                                kAudience[_selectedOption],
                                tokensProvider.tokens!.accessToken,
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const MentorExpertiseForm(),
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
                          },
                          color: kWhite,
                          iconSize: 20,
                          icon: const Icon(Icons.arrow_forward_ios),
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
    );
  }
}

class CustomMultiSelectButton2 extends StatefulWidget {
  final List<int> values1;
  final List<int> selectedValues1;
  final Function(List<int>) onChanged;
  final String text;

  const CustomMultiSelectButton2({
    Key? key,
    required this.values1,
    required this.selectedValues1,
    required this.onChanged,
    required this.text,
    required int groupValue,
  }) : super(key: key);

  @override
  State<CustomMultiSelectButton2> createState() =>
      _CustomMultiSelectButton2State();
}

class _CustomMultiSelectButton2State extends State<CustomMultiSelectButton2> {
  List<int> _selectedValues = [];

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues1;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedValues.contains(widget.values1.first)) {
            _selectedValues.clear();
          } else {
            _selectedValues = widget.values1;
          }

          widget.onChanged(_selectedValues);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedValues.contains(widget.values1.first)
              ? kPrimary
              : Colors.transparent,
          border: Border.all(
            color: kPrimary,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: widget.text,
              style: TextStyle(
                color: _selectedValues.contains(widget.values1.first)
                    ? Colors.white
                    : kPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
