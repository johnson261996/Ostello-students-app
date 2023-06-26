import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './username_form.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';

class MentorNameForm extends StatefulWidget {
  const MentorNameForm({Key? key}): super(key: key);

  @override
  State<MentorNameForm> createState() => _MentorNameFormState();
}

class _MentorNameFormState extends State<MentorNameForm> {
  String? _firstName;
  String? _lastName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Hey Mentor",
                        style: textTheme.headlineMedium,
                      ),
                    ),
                    Text(
                      "My name's Ostello, What's yours?",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          _firstName = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "First name",
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          _lastName = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Last name",
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0,
                    child: CircleAvatar(
                      backgroundColor: kPrimary,
                      radius: 30,
                      child: IconButton(
                        onPressed: Navigator.of(context).pop,
                        color: kWhite,
                        iconSize: 20,
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: DotsSlider(total: 8, current: 0),
                  ),
                  CircleAvatar(
                    backgroundColor: _firstName != null && _lastName != null
                        ? kPrimary
                        : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _firstName != null && _lastName != null
                          ? () {
                              mentorProvider.updateMentor(
                                "name",
                                "$_firstName $_lastName",
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const UserNameForm(),
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
}
