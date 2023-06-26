import 'package:flutter/material.dart';
import 'package:ostello_mentor/pages/student_dashboard/psychometric_test/phase1/phase1congo.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../models/test.dart';
import '../../../../providers/test_provider.dart';
import '../../../../utils/test_constants.dart';
import '../../../bottomnavbar_wrapper.dart';
import '../../../mentor_dashboard/pages/forms/mentor_experience_form.dart';
import '../../user_questionnaire/widgets/dot_slider.dart';
import '../widgets/popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Phase1Que extends StatefulWidget {
  const Phase1Que({Key? key}) : super(key: key);

  @override
  State<Phase1Que> createState() => _Phase1QueState();
}

class _Phase1QueState extends State<Phase1Que> {
  int _selectedOption = -1;
  int _currentQuestionIndex = 0;
  int currentQuestionno = 0;
  TestProvider testProvider = TestProvider();
  List<Option> results=[];
  List<Map<String, dynamic>> _currentQuestionSet = kP1Que1;


  final List<List<Map<String, dynamic>>> _questionSetsP1 = [
    kP1Que1,
    kP1Que2,
    kP1Que3,
    kP1Que4,
    kP1Que5,
    kP1Que6,
    kP1Que7,
    kP1Que8,
  ];

  void _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentQuestionIndex', _currentQuestionIndex);
    await prefs.setInt('selectedOption', _selectedOption);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questionSetsP1.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        currentQuestionno = _currentQuestionIndex;
        _currentQuestionSet = _questionSetsP1[_currentQuestionIndex];
        _selectedOption =
            int.parse(testProvider.answers[_currentQuestionIndex].option);
        // print(_selectedOption);
        // print('que: $_currentQuestionIndex');
      });
    }
  }

  void _prevQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        currentQuestionno = _currentQuestionIndex;
        _currentQuestionSet = _questionSetsP1[_currentQuestionIndex];
        _selectedOption =
            int.parse(testProvider.answers[_currentQuestionIndex].option);
        // print(_selectedOption);
        // print('que: $_currentQuestionIndex');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieveProgress();
  }

  void _retrieveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedQuestionIndex = prefs.getInt('currentQuestionIndex');
    int? savedSelectedOption = prefs.getInt('selectedOption');

    if (savedQuestionIndex != null && savedSelectedOption != null) {
      setState(() {
        _currentQuestionIndex = savedQuestionIndex;
        _selectedOption = savedSelectedOption;
        _currentQuestionSet = _questionSetsP1[_currentQuestionIndex];
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
                      "Phase 1",
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
                                _saveProgress();
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const BottomNavbarWrapper(),
                                  ),
                                );
                              },
                              onPressed2: () {
                                Navigator.of(context).push(
                                    PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const BottomNavbarWrapper(),
                                    ));
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
                   Expanded(
                     child: SizedBox(
                      height: 20,
                      child: DotsSlider(total: _questionSetsP1.length, current: currentQuestionno),
                  ),
                   ),
                  // CircleAvatar(
                  //   backgroundColor: kPrimary,
                  //   radius: 30,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       if (_currentQuestionIndex <
                  //           _questionSetsP1.length - 1) {
                  //         testProvider.skipQuestion(
                  //           "Kp${_currentQuestionIndex + 1}Que${_selectedOption + 1}",
                  //         );
                  //
                  //         _nextQuestion();
                  //       } else {
                  //         testProvider.SendResult(results,context);
                  //         Navigator.of(context).push(
                  //           PageTransition(
                  //             type: PageTransitionType.fade,
                  //             child: const Phase1Congratulations(),
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
                              _questionSetsP1.length - 1) {
                            _nextQuestion();
                          } else {
                            testProvider.SendResult(results,context);
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Phase1Congratulations(),
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
