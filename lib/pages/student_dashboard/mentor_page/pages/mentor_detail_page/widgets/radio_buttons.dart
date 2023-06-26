import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../utils/colours.dart';

class CustomRadioButton1 extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;

  const CustomRadioButton1({
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
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: groupValue == value ? Color(0xff1C4980) : Colors.transparent,
          border: Border.all(
            color: Color(0xff1C4980),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
                text: text,
                style: TextStyle(
                  color: groupValue == value ? Colors.white : Color(0xff1C4980),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ),
    );
  }
}

class CustomRadioButton2 extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;

  const CustomRadioButton2({
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
        width: MediaQuery.of(context).size.width * 0.28,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: groupValue == value ? kPrimary : Colors.transparent,
          border: Border.all(
            color: kPrimary,
            width: 0.8,
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

class CustomRadioButton3 extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;
  final IconData icon;

  const CustomRadioButton3({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: groupValue == value ? kPrimary : Colors.transparent,
          border: Border.all(
            color: kPrimary,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Row(
            children: [
              FaIcon(
                icon,
                size: 15,
                color: groupValue == value ? Colors.white : kPrimary,
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                    text: text,
                    style: TextStyle(
                      color: groupValue == value ? Colors.white : kPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRadioButton4 extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function onChanged;
  final String text;
  final IconData icon;

  const CustomRadioButton4({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.28,
        decoration: BoxDecoration(
          color: groupValue == value ? kPrimary : Colors.transparent,
          border: Border.all(
            color: kPrimary,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Stack(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: RichText(
                      text: TextSpan(
                        text: text,
                        style: TextStyle(
                          color: groupValue == value ? Colors.white : kPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (value == 1)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Free',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (value == 2 || value == 3)
                Positioned(
                  right: 6,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade600,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Paid',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
