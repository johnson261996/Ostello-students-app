import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';

class DotsSlider extends StatelessWidget {
  final int total;
  final int? current;

  const DotsSlider({Key? key, required this.total, this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
            (index) => Container(
          height:current == index ? 15: 10,
          width: current == index ? 15 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: current == index ? BoxShape.rectangle : BoxShape.circle,
            color: current == index ? kPrimary : kGray,
            borderRadius: current == index
                ? const BorderRadius.all(Radius.circular(15))
                : null,
          ),
        ),
      ),
    );
  }
}
