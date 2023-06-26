import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../apis/users.dart';
import '../../../../models/token.dart';
import '../../../../providers/student_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../utils/colours.dart';

class DOBForm extends StatefulWidget {
  const DOBForm({Key? key}) : super(key: key);

  @override
  State<DOBForm> createState() => _DOBFormState();
}

class _DOBFormState extends State<DOBForm> {
  String? _year;
  String? _month;
  String? _day;

  bool _daySubmit = false;
  bool _yearSubmit = false;
  bool _monthSubmit = false;

  late TokensProvider tokensProvider;
  late StudentProvider studentProvider;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void didChangeDependencies() {
    tokensProvider = context.read<TokensProvider>();
    studentProvider = context.read<StudentProvider>();

    if (studentProvider.student.dob != null) {
      setState(() {
        DateTime formattedDob = DateTime.parse(studentProvider.student.dob!);
        _day = DateFormat.d().format(formattedDob);
        _year = DateFormat.y().format(formattedDob);
        _month = DateFormat.m().format(formattedDob);

        _daySubmit = true;
        _yearSubmit = true;
        _monthSubmit = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
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
                    Text(
                      "When’s your birthday?",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "I don’t remember mine, but i will remember yours :)",
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            maxLength: 2,
                            initialValue: _day,
                            decoration: InputDecoration(
                              hintText: "DD",
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
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => _daySubmit = val.isNotEmpty);
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(() => _day = val);
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) < 1 ||
                                  int.parse(value) > 31) {
                                return 'Please enter a valid Date!';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            maxLength: 2,
                            initialValue: _month,
                            decoration: InputDecoration(
                              hintText: "MM",
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
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => _monthSubmit = val.isNotEmpty);
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(() => _month = val);
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 2 ||
                                  int.parse(value) < 1 ||
                                  int.parse(value) > 12) {
                                return 'Please enter a valid Month!';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            initialValue: _year,
                            decoration: InputDecoration(
                              hintText: "YYYY",
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
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => _yearSubmit = val.isNotEmpty);
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(() => _year = val);
                              }
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 4) {
                                return 'Please enter a valid Year!';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    CircleAvatar(
                      backgroundColor:
                          (_daySubmit && _monthSubmit && _yearSubmit)
                              ? kPrimary
                              : kLightGray,
                      radius: 30,
                      child: IconButton(
                        onPressed: (_daySubmit && _monthSubmit && _yearSubmit)
                            ? () {
                                if (_key.currentState != null &&
                                    _key.currentState!.validate()) {
                                  _key.currentState!.save();

                                  DateTime dob =
                                      DateTime.parse("$_year-$_month-$_day");

                                  studentProvider.updateStudent(
                                    "dob",
                                    DateFormat.yMMMd().format(dob),
                                  );

                                  signUpAPI(studentProvider.student.toJson())
                                      .then((tokens) {
                                    tokensProvider.setTokens =
                                        Tokens.fromJson(tokens);

                                    getStudentAPI(
                                            studentProvider.student.phoneNumber)
                                        .then((st) {
                                      studentProvider.updateStudent(
                                        "id",
                                        st.id,
                                      );
                                    });

                                    Navigator.of(context)
                                        .pushReplacementNamed("/success");
                                  });
                                }
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
