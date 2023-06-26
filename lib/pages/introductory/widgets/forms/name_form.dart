import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './dob_form.dart';
import '../../../../providers/student_provider.dart';
import '../../../../utils/colours.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  bool _firstNameFilled = false;
  bool _lastNameFilled = false;
  String _firstName = "";
  String _lastName = "";

  final _key = GlobalKey<FormState>();
  late StudentProvider studentProvider;

  @override
  void didChangeDependencies() {
    studentProvider = context.read<StudentProvider>();

    if (studentProvider.student.firstName != null) {
      setState(() => _firstNameFilled = true);
    }

    if (studentProvider.student.lastName != null) {
      setState(() => _lastNameFilled = true);
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
                      "Hey there buddy",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "My name’s Ostello, what’s yours?",
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      initialValue: studentProvider.student.firstName,
                      decoration: InputDecoration(
                        hintText: "First Name",
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
                        setState(() => _firstNameFilled = val.isNotEmpty);
                      },
                      onSaved: (val) {
                        if (val != null) {
                          setState(() => _firstName = val.trim());
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Name!';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      initialValue: studentProvider.student.lastName,
                      decoration: InputDecoration(
                        hintText: "Last Name",
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
                        setState(() => _lastNameFilled = val.isNotEmpty);
                      },
                      onSaved: (val) {
                        if (val != null) {
                          setState(() => _lastName = val.trim());
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Name!';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: (_firstNameFilled && _lastNameFilled)
                          ? kPrimary
                          : kLightGray,
                      radius: 30,
                      child: IconButton(
                        onPressed: (_firstNameFilled && _lastNameFilled)
                            ? () {
                                if (_key.currentState != null &&
                                    _key.currentState!.validate()) {
                                  _key.currentState!.save();
                                  studentProvider.updateStudent(
                                      "firstName", _firstName);
                                  studentProvider.updateStudent(
                                      "lastName", _lastName);

                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const DOBForm(),
                                    ),
                                  );
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
