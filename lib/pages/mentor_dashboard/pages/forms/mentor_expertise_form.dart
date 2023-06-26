import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mentor_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import '../membership/membership_info.dart';

class MentorExpertiseForm extends StatefulWidget {
  const MentorExpertiseForm({Key? key}): super(key: key);

  @override
  State<MentorExpertiseForm> createState() => _MentorExpertiseFormState();
}

class _MentorExpertiseFormState extends State<MentorExpertiseForm> {
  List _selectedInterests = [];

  @override
  void initState() {
    super.initState();

    _selectedInterests = List.generate(
      kExpertises.length,
      (idx) => {
        "field": kExpertises[idx],
        "selected": false,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mentorProvider = context.read<MentorProvider>();
    final tokensProvider = context.read<TokensProvider>();

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
                      "Please choose a minimum of 4 areas of expertise",
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: Scrollbar(
                        child: GridView.builder(
                          itemCount: kExpertises.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                          ),
                          itemBuilder: (ctx, idx) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedInterests[idx]["selected"] =
                                    !_selectedInterests[idx]["selected"];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: _selectedInterests[idx]["selected"]
                                      ? kPrimary
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    kExpertises[idx],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: _selectedInterests[idx]["selected"]
                                          ? Colors.white
                                          : kPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                    child: DotsSlider(total: 3, current: 2),
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        List<String> interests = [];

                        for (int i = 0; i < _selectedInterests.length; i++) {
                          if (_selectedInterests[i]["selected"]) {
                            interests.add(_selectedInterests[i]["field"]);
                          }
                        }

                        mentorProvider.updateMentor(
                          "interests",
                          interests,
                          tokensProvider.tokens!.accessToken,
                        );

                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const MembershipInfo(),
                          ),
                        );
                      },
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.check_rounded, size: 25),
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
