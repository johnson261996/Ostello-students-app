import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/pages/add_skill.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/pages/edit_about.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/pages/mentor_add_education.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/pages/mentor_add_experience.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/pages/mentor_edit_intro.dart';
import 'package:ostello_mentor/pages/mentor_dashboard/pages/mentor_profile/widgets/mentor_experience_card.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/themes.dart';
import 'widgets/mentor_education_card.dart';

class MentorProfile extends StatefulWidget {
  const MentorProfile({Key? key}) : super(key: key);

  @override
  State<MentorProfile> createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const int maxTextLength = 200;
    const String longText =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s. ' +
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.';
    final String truncatedText =
        isExpanded ? longText : longText.substring(0, maxTextLength);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: kPrimary,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/mentor/aditya.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Yash rawat',
                                  style: kLargeBoldTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                              Text(
                                "Founder & CEO",
                                style: kLargeTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kGray),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.edit,
                              size: 18,
                              color: kGray,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const MentorEditIntro(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: kGray.withOpacity(0.5),
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'About',
                                  style: kLargeBoldTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.edit,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const EditAbout(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: truncatedText,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'DMSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (longText.length > maxTextLength)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Text(
                                    isExpanded ? 'see less' : 'see more...',
                                    style: const TextStyle(
                                      color: kGray,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Education',
                              style: kLargeBoldTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.add,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const MentorAddEducation(),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.edit,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const MentorAddEducation(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const MentorEducationCard(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Work Experience',
                              style: kLargeBoldTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.add,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const MentorAddExperience(),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.edit,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const MentorAddExperience(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const MentorExperienceCard(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Skills',
                              style: kLargeBoldTextStyle.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.add,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const AddSkill(),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.edit,
                                  size: 18,
                                  color: kGray,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const AddSkill(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text('Update'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
