import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/themes.dart';
import '../../widgets/custom_radio_chip.dart';
import '../../widgets/dot_slider.dart';

class SchoolFormPage3 extends StatefulWidget {
  const SchoolFormPage3({Key? key}) : super(key: key);

  @override
  State<SchoolFormPage3> createState() => _SchoolFormPage3State();
}

class _SchoolFormPage3State extends State<SchoolFormPage3> {
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Please select your ',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: 'Stream',
                      style: kLargeBoldTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: kStreams.length,
                  itemBuilder: (ctx, idx) => CustomRadioChip(
                    value: idx,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                    text: kStreams[idx],
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
                    child: DotsSlider(total: 4, current: 3),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedOption != -1 ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedOption != -1
                          ? () {
                              studentProvider.updateStudent(
                                "stream",
                                kStreams[_selectedOption],
                                tokensProvider.tokens!.accessToken,
                              );

                              Navigator.of(context)
                                  .pushReplacementNamed('/student_dashboard');
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
