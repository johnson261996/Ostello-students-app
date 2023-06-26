import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final String pageName;
  final void Function() onTap;

  const PageButton({Key? key, required this.pageName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: media.width,
        height: 60,
        alignment: Alignment.centerLeft,
        child: Text(
          pageName,
          style: textTheme.headlineSmall!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
