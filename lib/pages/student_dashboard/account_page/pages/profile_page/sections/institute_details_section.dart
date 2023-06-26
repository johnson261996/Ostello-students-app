import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/institute_provider.dart';
import '../../../../../../providers/student_provider.dart';
import '../../../../../../providers/token_provider.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/constants.dart';
import '../widgets/student_profile_update_button.dart';

class InstitutionDetailsSection extends StatefulWidget {
  const InstitutionDetailsSection({Key? key}) : super(key: key);

  @override
  State<InstitutionDetailsSection> createState() =>
      _InstitutionDetailsSectionState();
}

class _InstitutionDetailsSectionState extends State<InstitutionDetailsSection> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final studentProvider = context.watch<StudentProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Institution Details",
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        StudentProfileUpdateButton(
          fieldName: "Current Institute",
          fieldValue: studentProvider.student.currentInstitute,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const EditCurrentInstituteField(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        StudentProfileUpdateButton(
          fieldName: "Mode of Coaching",
          fieldValue: studentProvider.student.coachingMode,
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => EditModeOfCoaching(
                  mode: studentProvider.student.coachingMode,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class EditCurrentInstituteField extends StatefulWidget {
  const EditCurrentInstituteField({Key? key}) : super(key: key);

  @override
  State<EditCurrentInstituteField> createState() =>
      _EditCurrentInstituteFieldState();
}

class _EditCurrentInstituteFieldState extends State<EditCurrentInstituteField> {
  bool _isChanged = false;
  String? _institute;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();
    final instituteProvider = context.read<InstituteProvider>();

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
                          "Current Institute",
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Please specify the Current Institute Name",
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          initialValue:
                              studentProvider.student.currentInstitute,
                          style: textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintText: "Institute Name",
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
                            if (val != "") {
                              instituteProvider.getInstitutes(val);
                            }

                            if (val.isNotEmpty && _isChanged != true) {
                              setState(() => _isChanged = true);
                            }
                          },
                          onSaved: (val) {
                            if (val != null) {
                              setState(() => _institute = val);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid Institute Name!';
                            }

                            return null;
                          },
                        ),
                        if (instituteProvider.institutes.isEmpty)
                          const Expanded(
                            child: Center(
                              child: Text("Your Institute is not Listed!"),
                            ),
                          )
                        else
                          Scrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: instituteProvider.institutes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _institute = instituteProvider
                                          .institutes[index].name;
                                    });

                                    studentProvider.updateStudent(
                                      "currentInstitute",
                                      _institute!,
                                      tokensProvider.tokens!.accessToken,
                                    );

                                    Navigator.of(context).pop();
                                  },
                                  child: ListTile(
                                    title: Text(
                                      instituteProvider.institutes[index].name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/profile/arrow-up-left.png',
                                      scale: 2.4,
                                      color: const Color(0xff263238),
                                    ),
                                  ),
                                );
                              },
                            ),
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

                                  if (_institute != null &&
                                      _institute !=
                                          studentProvider
                                              .student.currentInstitute) {
                                    studentProvider.updateStudent(
                                      "currentInstitute",
                                      _institute!,
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

class EditModeOfCoaching extends StatefulWidget {
  final String? mode;

  const EditModeOfCoaching({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  State<EditModeOfCoaching> createState() => _EditModeOfCoachingState();
}

class _EditModeOfCoachingState extends State<EditModeOfCoaching> {
  late MODES _mode;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _mode = MODES.values.firstWhere(
      (element) => widget.mode == element.toString().split(".").last,
      orElse: () => MODES.offline,
    );
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
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        "Current Mode of Coaching",
                        style: textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please specify the Mode of Coaching",
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: 50),
                      ListTile(
                        title: const Text('Offline'),
                        leading: Radio<MODES>(
                          value: MODES.offline,
                          groupValue: _mode,
                          onChanged: (MODES? value) {
                            if (value != null) {
                              setState(() {
                                _mode = value;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Online'),
                        leading: Radio<MODES>(
                          value: MODES.online,
                          groupValue: _mode,
                          onChanged: (MODES? value) {
                            if (value != null) {
                              setState(() {
                                _mode = value;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Hybrid'),
                        leading: Radio<MODES>(
                          value: MODES.hybrid,
                          groupValue: _mode,
                          onChanged: (MODES? value) {
                            if (value != null) {
                              setState(() {
                                _mode = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: studentProvider.student.coachingMode !=
                                  _mode.toString().split(".").last
                              ? () {
                                  if (_key.currentState != null &&
                                      _key.currentState!.validate()) {
                                    _key.currentState!.save();

                                    studentProvider.updateStudent(
                                      "coachingMode",
                                      _mode.toString().split(".").last,
                                      tokensProvider.tokens!.accessToken,
                                    );

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
      ),
    );
  }
}
