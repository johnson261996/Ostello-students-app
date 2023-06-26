import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import 'short_bio_form.dart';

class UserNameForm extends StatefulWidget {
  const UserNameForm({Key? key}): super(key: key);

  @override
  State<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends State<UserNameForm> {
  String? _username;

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
                      "Let's get started!",
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      "Please create a username to join and enjoy the app.",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          _username = val;
                        });
                      },
                      decoration: InputDecoration(
                        icon: const Icon(Icons.alternate_email),
                        hintText: "ostello7",
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
                    child: DotsSlider(total: 8, current: 1),
                  ),
                  CircleAvatar(
                    backgroundColor: _username != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _username != null
                          ? () {
                              mentorProvider.updateMentor(
                                "username",
                                "@$_username",
                              );

                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const ShortBioForm(),
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
