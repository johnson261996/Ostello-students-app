import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './mentoring_type.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/themes.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';

class MentorTypeSelection extends StatefulWidget {
  const MentorTypeSelection({Key? key}) : super(key: key);

  @override
  State<MentorTypeSelection> createState() => _MentorTypeSelectionState();
}

class _MentorTypeSelectionState extends State<MentorTypeSelection> {
  List _selectedInterests = [];

  @override
  void initState() {
    super.initState();

    _selectedInterests = List.generate(
      kInterests.length,
      (idx) => {
        "field": kInterests[idx],
        "selected": false,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final mentorProvider = context.read<MentorProvider>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Hey ',
                              style: kLargeTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: '${mentorProvider.mentor.name}',
                              style: kLargeBoldTextStyle,
                            ),
                            TextSpan(
                              text:
                                  ',\nnice to meet you! How about we get to know each other better?',
                              style: kLargeTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      RichText(
                        text: const TextSpan(
                          text: 'Choose your Interest*',
                          style: kBodyTextStyle,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "(multiple options can be selected) ",
                          style: TextStyle(
                            color: kGray,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: kInterests.length,
                          separatorBuilder: (ctx, idx) =>
                              const SizedBox(height: 10),
                          itemBuilder: (ctx, idx) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedInterests[idx]["selected"] =
                                    !_selectedInterests[idx]["selected"];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
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
                                  kInterests[idx],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
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
                      child: DotsSlider(total: 3, current: 0),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          _selectedInterests.isNotEmpty ? kPrimary : kLightGray,
                      radius: 30,
                      child: IconButton(
                        onPressed: _selectedInterests.isNotEmpty
                            ? () {
                                List<String> interests = [];

                                for (int i = 0;
                                    i < _selectedInterests.length;
                                    i++) {
                                  if (_selectedInterests[i]["selected"]) {
                                    interests
                                        .add(_selectedInterests[i]["field"]);
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
                                    child: const MentoringType(),
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
      ),
    );
  }
}
