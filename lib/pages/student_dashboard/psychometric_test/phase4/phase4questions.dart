import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase1/phase1congo.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase4/phase4congo.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../models/test.dart';
import '../../../../providers/test_provider.dart';
import '../../../../utils/test_constants.dart';
import '../../../mentor_dashboard/pages/forms/mentor_experience_form.dart';
import '../../user_questionnaire/widgets/dot_slider.dart';
import '../phase2/phase2congo.dart';
import '../widgets/popup.dart';


class Phase4Que extends StatefulWidget {
  const Phase4Que({Key? key}) : super(key: key);

  @override
  State<Phase4Que> createState() => _Phase4QueState();
}

class _Phase4QueState extends State<Phase4Que> {
  int _selectedOption = -1;
  int _currentQuestionIndex = 0;
  TestProvider testProvider = TestProvider();
  List<Map<String, dynamic>> _currentQuestionSet = kP2Que1;
  List<Option> results=[];

  final List<List<Map<String, dynamic>>> _questionSetsP2 = [

    kP2Que9,
    kP2Que10,
    kP2Que11,
    kP2Que12,
    kP2Que13,
    kP2Que14,
    kP2Que15,
  ];

  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _currentQuestionSet = _questionSetsP2[_currentQuestionIndex];
        _selectedOption =
            int.parse(testProvider.answers[_currentQuestionIndex].option);
        // print(_selectedOption);
        // print('que: $_currentQuestionIndex');
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questionSetsP2.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _currentQuestionSet = _questionSetsP2[_currentQuestionIndex];
        _selectedOption = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final testProvider = context.read<TestProvider>();
    final textTheme = Theme.of(context).textTheme;
    for (int i = 0; i < testProvider.answers.length; i++) {
      Option answer = testProvider.answers[i];

      results.add(testProvider.answers[i]);
      print('Weightage: ${answer.weightage}');
      //print('option: ${answer.option}');
      //print('questionId: ${answer.questionId}');
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 120.0),
                    child: Text(
                      "Phase 4",
                      style: textTheme.headlineLarge?.copyWith(
                        color: kBlack,
                        fontFamily: 'Roboto',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: kPrimary,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUp(
                              icon: Icons.save_rounded,
                              title: "Save test for later",
                              text:
                              'Are you sure you want to cancel the test? You can save your progress and resume it later.',
                              buttonText1: 'Save & Exit',
                              buttonText2: 'Cancel Test',
                              onPressed1: () {
                                // Perform an action for button 1
                              },
                              onPressed2: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "Q${_currentQuestionIndex + 1}. ${_currentQuestionSet[0]["question"]}",
                style: textTheme.headlineLarge?.copyWith(
                  color: kBlack,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: _currentQuestionSet.length,
                  itemBuilder: (ctx, idx) => CustomRadioChip(
                    value: idx,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                    text: _currentQuestionSet[idx]["option"],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        _prevQuestion();
                      },
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: DotsSlider(total: _questionSetsP2.length, current: _currentQuestionIndex),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: kPrimary,
                  //   radius: 30,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       if (_currentQuestionIndex < _questionSetsP2.length - 1) {
                  //         testProvider.skipQuestion(
                  //           "Kp${_currentQuestionIndex + 1}Que${_selectedOption + 1}",
                  //         );
                  //         _nextQuestion();
                  //       } else {
                  //         testProvider.SendResult(results,context);
                  //         Navigator.of(context).push(
                  //           PageTransition(
                  //             type: PageTransitionType.fade,
                  //             child: const Phase4Congratulations(),
                  //           ),
                  //         );
                  //       }
                  //     },
                  //     color: kWhite,
                  //     iconSize: 20,
                  //     icon: const Icon(Icons.skip_next),
                  //     tooltip: 'Skip',
                  //   ),
                  // ),
                  CircleAvatar(
                    backgroundColor:
                    _selectedOption != -1 ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        if (_selectedOption != -1) {
                          // testProvider.updateAnswer(Option(
                          //   questionId:
                          //       "Kp${_currentQuestionIndex + 1}Que${_selectedOption + 1}",
                          //   option: _selectedOption,
                          //   weightage: _currentQuestionSet[_selectedOption]
                          //       ["weightage"],
                          // ));
                          Option currentOption =
                          testProvider.answers[_currentQuestionIndex];
                          Option updatedOption = Option(
                            questionId:
                            "Q${_currentQuestionIndex + 1}. ${_currentQuestionSet[0]["question"]}",
                            option: currentOption.option,
                            weightage: currentOption.weightage,
                          );
                          testProvider.updateAnswer(
                              _currentQuestionIndex, updatedOption);
                          testProvider.updateAnswer(
                              _currentQuestionIndex,
                              Option(
                                questionId:
                                "${_currentQuestionIndex}Que${_selectedOption + 1}",
                                option: _selectedOption,
                                weightage: _currentQuestionSet[_selectedOption]
                                ["weightage"],
                              ));
                          if (_currentQuestionIndex <
                              _questionSetsP2.length - 1) {
                            _nextQuestion();
                          } else {
                            // int totalWeightage = 0;
                            // for (int i = 6; i < _questionSets.length; i++) {
                            //   for (final option in _questionSets[i]) {
                            //     totalWeightage += option['weightage'] as int;
                            //   }
                            // }
                            // print('Total Weightage: $totalWeightage');
                            testProvider.SendResult(results,context);
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Phase4Congratulations(),
                              ),
                            );
                          }
                        }
                      },
                      color: kWhite,
                      iconSize: 20,
                      tooltip: 'Next',
                      icon: const Icon(Icons.arrow_forward_ios, size: 25),
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
