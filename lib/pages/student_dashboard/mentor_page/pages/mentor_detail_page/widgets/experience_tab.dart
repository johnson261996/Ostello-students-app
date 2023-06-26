import 'package:flutter/material.dart';

import './experience_card.dart';
import '../../../../../../models/mentor.dart';

class ExperienceTab extends StatelessWidget {
  final List<MentorExperience> experiences;

  const ExperienceTab({
    Key? key,
    required this.experiences,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: experiences.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (ctx, idx) => ExperienceCard(
        experience: experiences[idx],
      ),
      separatorBuilder: (ctx, idx) => const SizedBox(height: 20),
    );
  }
}
