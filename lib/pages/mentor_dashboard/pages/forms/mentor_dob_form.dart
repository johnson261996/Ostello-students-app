import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import 'pick_avatar_form.dart';

class MentorDOBForm extends StatefulWidget {
  const MentorDOBForm({Key? key}): super(key: key);

  @override
  State<MentorDOBForm> createState() => _MentorDOBFormState();
}

class _MentorDOBFormState extends State<MentorDOBForm> {
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "When’s your birthday?",
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      "Please choose your Date of birth",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _dob == null
                                ? 'Select Date of Birth'
                                : DateFormat.yMMMd().format(_dob!),
                            style: textTheme.bodyLarge,
                          ),
                          IconButton(
                            onPressed: _selectDate,
                            icon: const Icon(Icons.calendar_month_rounded),
                          ),
                        ],
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
                    child: DotsSlider(total: 8, current: 4),
                  ),
                  CircleAvatar(
                    backgroundColor: _dob != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _dob != null
                          ? () {
                              mentorProvider.updateMentor(
                                "dob",
                                DateFormat.yMMMd().format(_dob!),
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const PickAvatarForm(),
                                ),
                              );
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }
}
