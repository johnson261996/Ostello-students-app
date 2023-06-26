import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/student_provider.dart';
import '../../../../../../providers/token_provider.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/constants.dart';
import '../widgets/student_profile_update_button.dart';

class AcademicDataSection extends StatefulWidget {
  const AcademicDataSection({Key? key}) : super(key: key);

  @override
  State<AcademicDataSection> createState() => _AcademicDataSectionState();
}

class _AcademicDataSectionState extends State<AcademicDataSection> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final studentProvider = context.watch<StudentProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Academic Data",
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        StudentProfileUpdateButton(
          fieldName: "School",
          fieldValue: studentProvider.student.schoolName,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const SchoolEditPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        StudentProfileUpdateButton(
          fieldName: "Class",
          fieldValue: studentProvider.student.grade,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    ClassEditPage(grade: studentProvider.student.grade),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        StudentProfileUpdateButton(
          fieldName: "Target Exam",
          fieldValue: studentProvider.student.targetExam,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TargetExamEditPage(
                    targetExam: studentProvider.student.targetExam),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        StudentProfileUpdateButton(
          fieldName: "Ambition",
          fieldValue: studentProvider.student.ambition,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AmbitionEditPage()),
            );
          },
        ),
      ],
    );
  }
}

class SchoolEditPage extends StatefulWidget {
  const SchoolEditPage({Key? key}) : super(key: key);

  @override
  State<SchoolEditPage> createState() => _SchoolEditPageState();
}

class _SchoolEditPageState extends State<SchoolEditPage> {
  bool _isChanged = false;
  String? _school;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: SizedBox(
          height: media.height,
          width: media.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: media.height - 200,
                  width: media.width,
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimary,
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: kWhite,
                            iconSize: 20,
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "School",
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Enter the name of your school",
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          initialValue: studentProvider.student.schoolName,
                          style: textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintText: "School Name",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: kPrimary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: kLightGray,
                                width: 2,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            if (val.isNotEmpty && _isChanged != true) {
                              setState(() => _isChanged = true);
                            }
                          },
                          onSaved: (val) {
                            if (val != null) {
                              setState(() => _school = val);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid School Name!';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isChanged
                            ? () {
                                setState(() => _isChanged = false);

                                if (_key.currentState != null &&
                                    _key.currentState!.validate()) {
                                  _key.currentState!.save();

                                  if (_school != null &&
                                      _school !=
                                          studentProvider.student.schoolName) {
                                    studentProvider.updateStudent(
                                      "schoolName",
                                      _school!,
                                      tokensProvider.tokens!.accessToken,
                                    );
                                  }

                                  Navigator.of(context).pop();
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 30,
                          ),
                        ),
                        child: const Text("Save & Continue"),
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

class ClassEditPage extends StatefulWidget {
  final String? grade;

  const ClassEditPage({Key? key, required this.grade}) : super(key: key);

  @override
  State<ClassEditPage> createState() => _ClassEditPageState();
}

class _ClassEditPageState extends State<ClassEditPage> {
  bool _isChanged = false;
  late int curIdx;

  @override
  void initState() {
    super.initState();
    int idx = kClasses.indexWhere((element) => element == widget.grade);
    curIdx = idx == -1 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: SizedBox(
          height: media.height,
          width: media.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: media.height - 200,
                  width: media.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: kPrimary,
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: kWhite,
                          iconSize: 20,
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Class",
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Choose your standard",
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                        child: ListView.builder(
                          itemCount: kClasses.length,
                          itemBuilder: (ctx, idx) => Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                setState(() => curIdx = idx);

                                if (_isChanged != true) {
                                  setState(() => _isChanged = true);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: curIdx == idx
                                      ? kPrimary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                      color:
                                          curIdx == idx ? kWhite : kLightGray),
                                ),
                                child: Text(
                                  kClasses[idx],
                                  style: textTheme.bodySmall!.copyWith(
                                    color: curIdx == idx ? kWhite : kGray,
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
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isChanged
                            ? () {
                                setState(() => _isChanged = false);

                                if (kClasses[curIdx] !=
                                    studentProvider.student.grade) {
                                  studentProvider.updateStudent(
                                    "grade",
                                    kClasses[curIdx],
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                Navigator.of(context).pop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 30,
                          ),
                        ),
                        child: const Text("Save & Continue"),
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

class TargetExamEditPage extends StatefulWidget {
  final String? targetExam;

  const TargetExamEditPage({
    Key? key,
    required this.targetExam,
  }) : super(key: key);

  @override
  State<TargetExamEditPage> createState() => _TargetExamEditPageState();
}

class _TargetExamEditPageState extends State<TargetExamEditPage> {
  bool _isChanged = false;
  late EXAMS _exam;

  @override
  void initState() {
    super.initState();
    _exam = EXAMS.values.firstWhere(
        (element) => element.toString().split(".")[1] == widget.targetExam,
        orElse: () => EXAMS.none);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: SizedBox(
          height: media.height,
          width: media.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: media.height - 200,
                  width: media.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: kPrimary,
                        radius: 25,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: kWhite,
                          iconSize: 20,
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Target Exam",
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please select your target exam",
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: 25),
                      ListTile(
                        title: const Text('Board Exams'),
                        leading: Radio<EXAMS>(
                          value: EXAMS.boards,
                          groupValue: _exam,
                          onChanged: (EXAMS? value) {
                            if (_isChanged != true) {
                              setState(() => _isChanged = true);
                            }

                            if (value != null) {
                              setState(() {
                                _exam = value;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('JEE Mains'),
                        leading: Radio<EXAMS>(
                          value: EXAMS.jeeMains,
                          groupValue: _exam,
                          onChanged: (EXAMS? value) {
                            if (_isChanged != true) {
                              setState(() => _isChanged = true);
                            }

                            if (value != null) {
                              setState(() {
                                _exam = value;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('JEE Advanced'),
                        leading: Radio<EXAMS>(
                          value: EXAMS.jeeAdvanced,
                          groupValue: _exam,
                          onChanged: (EXAMS? value) {
                            if (_isChanged != true) {
                              setState(() => _isChanged = true);
                            }

                            if (value != null) {
                              setState(() {
                                _exam = value;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('NEET'),
                        leading: Radio<EXAMS>(
                          value: EXAMS.neet,
                          groupValue: _exam,
                          onChanged: (EXAMS? value) {
                            if (_isChanged != true) {
                              setState(() => _isChanged = true);
                            }

                            if (value != null) {
                              setState(() {
                                _exam = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isChanged
                            ? () {
                                setState(() => _isChanged = false);

                                if (_exam.toString().split(".")[1] !=
                                    studentProvider.student.targetExam) {
                                  studentProvider.updateStudent(
                                    "targetExam",
                                    _exam.toString().split(".")[1],
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                Navigator.of(context).pop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 30,
                          ),
                        ),
                        child: const Text("Save & Continue"),
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

class AmbitionEditPage extends StatefulWidget {
  const AmbitionEditPage({Key? key}) : super(key: key);

  @override
  State<AmbitionEditPage> createState() => _AmbitionEditPageState();
}

class _AmbitionEditPageState extends State<AmbitionEditPage> {
  bool _isChanged = false;
  String? _ambition;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: SizedBox(
          height: media.height,
          width: media.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: media.height - 200,
                  width: media.width,
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimary,
                          radius: 25,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: kWhite,
                            iconSize: 20,
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "What do you want to become?",
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Please specify your goal",
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          initialValue: studentProvider.student.ambition,
                          style: textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintText: "Goal...",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: kPrimary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: kLightGray,
                                width: 2,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            if (val.isNotEmpty && _isChanged != true) {
                              setState(() => _isChanged = true);
                            }
                          },
                          onSaved: (val) {
                            if (val != null) {
                              setState(() => _ambition = val);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid Ambition!';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isChanged
                            ? () {
                                setState(() => _isChanged = false);

                                if (_key.currentState != null &&
                                    _key.currentState!.validate()) {
                                  _key.currentState!.save();

                                  if (_ambition != null &&
                                      _ambition !=
                                          studentProvider.student.ambition) {
                                    studentProvider.updateStudent(
                                      "ambition",
                                      _ambition!,
                                      tokensProvider.tokens!.accessToken,
                                    );
                                  }

                                  Navigator.of(context).pop();
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 30,
                          ),
                        ),
                        child: const Text("Save & Continue"),
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
