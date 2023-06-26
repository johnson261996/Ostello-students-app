import 'package:flutter/material.dart';

class StudentProfileUpdateButton extends StatefulWidget {
  final String fieldName;
  final String? fieldValue;
  final void Function() callback;

  const StudentProfileUpdateButton({
    Key? key,
    required this.fieldName,
    required this.fieldValue,
    required this.callback,
  }) : super(key: key);

  @override
  State<StudentProfileUpdateButton> createState() =>
      _StudentProfileUpdateButtonState();
}

class _StudentProfileUpdateButtonState
    extends State<StudentProfileUpdateButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fieldName,
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 5),
            Text(
              widget.fieldValue != null ? widget.fieldValue! : "",
              style: textTheme.bodySmall!.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: widget.callback,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
