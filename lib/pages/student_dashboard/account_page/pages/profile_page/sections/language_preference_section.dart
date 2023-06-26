import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/student_provider.dart';
import '../../../../../../providers/token_provider.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/constants.dart';
import '../widgets/student_profile_update_button.dart';

class LanguagePreferenceSection extends StatefulWidget {
  const LanguagePreferenceSection({Key? key}) : super(key: key);

  @override
  State<LanguagePreferenceSection> createState() =>
      _LanguagePreferenceSectionState();
}

class _LanguagePreferenceSectionState extends State<LanguagePreferenceSection> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final studentProvider = context.watch<StudentProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language Preference",
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        StudentProfileUpdateButton(
          fieldName: "Language of teaching",
          fieldValue: studentProvider.student.languageModeTeaching != null
              ? studentProvider.student.languageModeTeaching![0].toUpperCase() +
                  studentProvider.student.languageModeTeaching!.substring(1)
              : "",
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => EditLanguageOfTeachingField(
                  languageModeTeaching:
                      studentProvider.student.languageModeTeaching,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        StudentProfileUpdateButton(
          fieldName: "Language of books",
          fieldValue: studentProvider.student.languageModeBooks != null
              ? studentProvider.student.languageModeBooks![0].toUpperCase() +
                  studentProvider.student.languageModeBooks!.substring(1)
              : "",
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => EditLanguageOfBooksField(
                  languageModeBooks: studentProvider.student.languageModeBooks,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class EditLanguageOfTeachingField extends StatefulWidget {
  final String? languageModeTeaching;

  const EditLanguageOfTeachingField({
    Key? key,
    required this.languageModeTeaching,
  }) : super(key: key);

  @override
  State<EditLanguageOfTeachingField> createState() =>
      _EditLanguageOfTeachingFieldState();
}

class _EditLanguageOfTeachingFieldState
    extends State<EditLanguageOfTeachingField> {
  bool _submit = false;
  late LANGUAGES _language;
  late String? _otherLanguage;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _language = LANGUAGES.values.firstWhere(
        (element) =>
            widget.languageModeTeaching == element.toString().split(".").last,
        orElse: () => LANGUAGES.english);

    if (widget.languageModeTeaching ==
        LANGUAGES.other.toString().split(".").last) {
      _otherLanguage = widget.languageModeTeaching;
    } else {
      _otherLanguage = "";
    }
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
                              "Language of Teaching",
                              style: textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Please specify the language you are comfortable in",
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 50),
                            ListTile(
                              title: const Text('Hindi'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.hindi,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('English'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.english,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Other'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.other,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            if (_language == LANGUAGES.other)
                              TextFormField(
                                initialValue: widget.languageModeTeaching,
                                decoration: InputDecoration(
                                  hintText: "Your preferred language",
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
                                  setState(() => _submit = val.isNotEmpty);
                                },
                                onSaved: (val) {
                                  if (val != null) {
                                    setState(() => _otherLanguage = val);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid Language!';
                                  }

                                  return null;
                                },
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: studentProvider
                                            .student.languageModeTeaching !=
                                        _language.toString().split(".").last
                                    ? () {
                                        if (_key.currentState != null &&
                                            _key.currentState!.validate()) {
                                          _key.currentState!.save();

                                          studentProvider.updateStudent(
                                            "languageModeTeaching",
                                            _language == LANGUAGES.other
                                                ? _otherLanguage!
                                                : _language
                                                    .toString()
                                                    .split(".")
                                                    .last,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditLanguageOfBooksField extends StatefulWidget {
  final String? languageModeBooks;

  const EditLanguageOfBooksField({
    Key? key,
    required this.languageModeBooks,
  }) : super(key: key);

  @override
  State<EditLanguageOfBooksField> createState() =>
      _EditLanguageOfBooksFieldState();
}

class _EditLanguageOfBooksFieldState extends State<EditLanguageOfBooksField> {
  bool _submit = false;
  late LANGUAGES _language;
  late String? _otherLanguage;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _language = LANGUAGES.values.firstWhere(
        (element) =>
            widget.languageModeBooks == element.toString().split(".").last,
        orElse: () => LANGUAGES.other);

    if (widget.languageModeBooks ==
        LANGUAGES.other.toString().split(".").last) {
      _otherLanguage = widget.languageModeBooks;
    } else {
      _otherLanguage = "";
    }
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
                              "Language of Books",
                              style: textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Please specify the language you are comfortable in",
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 50),
                            ListTile(
                              title: const Text('Hindi'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.hindi,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('English'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.english,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Other'),
                              leading: Radio<LANGUAGES>(
                                value: LANGUAGES.other,
                                groupValue: _language,
                                onChanged: (LANGUAGES? value) {
                                  if (_submit != true) {
                                    setState(() => _submit = true);
                                  }

                                  if (value != null) {
                                    setState(() {
                                      _language = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            if (_language == LANGUAGES.other)
                              TextFormField(
                                initialValue: widget.languageModeBooks,
                                decoration: InputDecoration(
                                  hintText: "Your preferred language",
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
                                  setState(() => _submit = val.isNotEmpty);
                                },
                                onSaved: (val) {
                                  if (val != null) {
                                    setState(() => _otherLanguage = val);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid Language!';
                                  }

                                  return null;
                                },
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: studentProvider
                                            .student.languageModeBooks !=
                                        _language.toString().split(".").last
                                    ? () {
                                        if (_key.currentState != null &&
                                            _key.currentState!.validate()) {
                                          _key.currentState!.save();

                                          studentProvider.updateStudent(
                                            "languageModeBooks",
                                            _language == LANGUAGES.other
                                                ? _otherLanguage!
                                                : _language
                                                    .toString()
                                                    .split(".")
                                                    .last,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
