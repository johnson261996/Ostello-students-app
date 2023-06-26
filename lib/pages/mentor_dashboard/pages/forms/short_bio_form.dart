import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './linkedin_form.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';

class ShortBioForm extends StatefulWidget {
  const ShortBioForm({Key? key}): super(key: key);

  @override
  State<ShortBioForm> createState() => _ShortBioFormState();
}

class _ShortBioFormState extends State<ShortBioForm> {
  String? _shortBio;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();

    return Scaffold(
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
                      "Short Bio",
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      "We would be really interested in knowing you more",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          _shortBio = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "I’m am proficient in English....",
                        contentPadding:
                            const EdgeInsets.only(bottom: 100, left: 10),
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
                    child: DotsSlider(total: 8, current: 2),
                  ),
                  CircleAvatar(
                    backgroundColor: _shortBio != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _shortBio != null
                          ? () {
                              mentorProvider.updateMentor(
                                "shortbio",
                                _shortBio,
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const LinkedinForm(),
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
