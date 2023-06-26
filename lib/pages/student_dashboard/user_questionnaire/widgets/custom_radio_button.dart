import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';

class CustomRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;

  const CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: groupValue == value ? kPrimary : Colors.transparent,
          border: Border.all(
            color: kPrimary,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
                text: text,
                style: TextStyle(
                  color: groupValue == value ? Colors.white : kPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ),
    );
  }
}
