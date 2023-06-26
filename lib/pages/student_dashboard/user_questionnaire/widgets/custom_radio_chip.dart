import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';

class CustomRadioChip extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;

  const CustomRadioChip({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onChanged(value);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: groupValue == value ? kPrimary : Colors.transparent,
              border: Border.all(
                color: groupValue == value ? kPrimary : kGray,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(99),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: text,
                      style: TextStyle(
                        color: groupValue == value ? Colors.white : kGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
