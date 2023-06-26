import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/student_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';
import '../../widgets/dot_slider.dart';

class ParentFormPage extends StatefulWidget {
  const ParentFormPage({Key? key}) : super(key: key);

  @override
  State<ParentFormPage> createState() => _ParentFormPageState();
}

class _ParentFormPageState extends State<ParentFormPage> {
  String? _studentDescription;

  @override
  Widget build(BuildContext context) {
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "As a new parent user, please let us know what you hope to gain from using our app for your ",
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: "Child's Education?",
                      style: kLargeBoldTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: TextField(
                  onChanged: (val) {
                    setState(() => _studentDescription = val);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimary, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimary, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Please write here...',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                    contentPadding:
                        const EdgeInsets.only(bottom: 100, left: 10),
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
                      onPressed: Navigator.of(context).pop,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: DotsSlider(total: 2, current: 1),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _studentDescription != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _studentDescription != null
                          ? () {
                              if (_studentDescription != null) {
                                studentProvider.updateStudent(
                                  "description",
                                  _studentDescription!,
                                );

                                Navigator.of(context)
                                    .pushReplacementNamed("/student_dashboard");
                              }
                            }
                          : null,
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
