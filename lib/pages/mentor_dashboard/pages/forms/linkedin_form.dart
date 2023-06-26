import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './mentor_dob_form.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';

class LinkedinForm extends StatefulWidget {
  const LinkedinForm({Key? key}): super(key: key);

  @override
  State<LinkedinForm> createState() => _LinkedinFormState();
}

class _LinkedinFormState extends State<LinkedinForm> {
  String? _linkedIn;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Linkedin Profile",
                          style: textTheme.headlineMedium,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const MentorDOBForm(),
                            ),
                          ),
                          child: Text(
                            "Skip",
                            style: textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Please share your linkedin profile URL",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          if (_linkedIn != null &&
                              _linkedIn!.startsWith("https://")) {
                            _linkedIn = val;
                          } else {
                            _linkedIn = "https://linkedin.com/$val";
                          }
                        });
                      },
                      decoration: InputDecoration(
                        icon: const FaIcon(FontAwesomeIcons.linkedin),
                        hintText: "https://linkedin.com/ostello7",
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
                    child: DotsSlider(total: 8, current: 3),
                  ),
                  CircleAvatar(
                    backgroundColor: _linkedIn != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _linkedIn != null
                          ? () {
                              mentorProvider.updateMentor(
                                "linkedin",
                                _linkedIn,
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const MentorDOBForm(),
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
