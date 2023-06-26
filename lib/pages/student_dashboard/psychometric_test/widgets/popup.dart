import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';

class PopUp extends StatelessWidget {
  final IconData icon;
  final String text;
  final String title;
  final String buttonText1;
  final String buttonText2;
  final Function() onPressed1;
  final Function() onPressed2;

  const PopUp({
    Key? key,
    required this.icon,
    required this.text,
    required this.buttonText1,
    required this.buttonText2,
    required this.onPressed1,
    required this.onPressed2,
    required this.title,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.0),
            const SizedBox(height: 22.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.headlineLarge?.copyWith(
                color: kBlack,
                fontFamily: 'Roboto',
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 22.0),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 22.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onPressed1,
                  child: Text(buttonText1),
                ),
                TextButton(
                  onPressed: onPressed2,
                  child: Text(buttonText2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
