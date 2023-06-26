import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './mentor_experience_form.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/geo_location.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';

class MentorLocationForm extends StatefulWidget {
  const MentorLocationForm({Key? key}): super(key: key);

  @override
  State<MentorLocationForm> createState() => _MentorLocationFormState();
}

class _MentorLocationFormState extends State<MentorLocationForm> {
  bool _loading = false;
  bool _fetchedLocation = false;

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
              if (_loading)
                const SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(),
                )
              else
                const SizedBox(height: 2),
              const SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location Permission ",
                        style: textTheme.headlineMedium,
                      ),
                      Text(
                        "Help us locate you in the best suitable mentees",
                        style: textTheme.headlineSmall!.copyWith(
                          color: kGray,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });

                          final location = await determinePosition();
                          await mentorProvider.updateUserLocation(location);

                          setState(() {
                            _fetchedLocation = true;
                            _loading = false;
                          });
                        },
                        child: const Row(
                          children: [
                            Text("Fetch Location"),
                            SizedBox(width: 10),
                            Icon(Icons.location_on_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    child: DotsSlider(total: 8, current: 6),
                  ),
                  CircleAvatar(
                    backgroundColor: _fetchedLocation ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _fetchedLocation
                          ? () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const MentorExperienceForm(),
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
