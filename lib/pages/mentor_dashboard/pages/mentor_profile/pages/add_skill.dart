import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/mentor_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({Key? key}) : super(key: key);

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  List<String> skills = [];

  void addSkills(String skillName) {
    skills.add(skillName);
    print(skills);
    setState(() {});
  }

  void removeSkills(String skillName) {
    skills.remove(skillName);
    print(skills);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final mentorProvider = context.read<MentorProvider>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: kPrimary,
                      radius: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        color: Colors.white,
                        iconSize: 15,
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Skill",
                          style:
                              textTheme.headlineLarge?.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "* Indicates required",
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          onSubmitted: (skill) {
                            addSkills(skill);
                          },
                          cursorColor: kGray,
                          decoration: InputDecoration(
                            labelText: 'Enter Skill',
                            hintText: 'Enter Skill',
                            labelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 24,
                          children: skills.map(
                            (skill) {
                              return Chip(
                                backgroundColor: kGray.withOpacity(0.1),
                                onDeleted: () {
                                  removeSkills(skill);
                                },
                                deleteIcon: const Icon(
                                  Icons.remove_circle,
                                  color: kPrimary,
                                ),
                                label: Text(skill),
                              );
                            },
                          ).toList(),
                        ),
                        if (skills.isEmpty)
                          const Center(
                            child: Text('No Skills available!'),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  mentorProvider.updateMentor(
                                    "skills",
                                    skills,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  minimumSize: const Size(double.infinity, 0),
                                ),
                                child: const Text('Save'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
