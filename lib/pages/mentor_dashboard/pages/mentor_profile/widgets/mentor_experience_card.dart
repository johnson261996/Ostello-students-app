import 'package:flutter/material.dart';

import '../../../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';

class MentorExperienceCard extends StatelessWidget {
  const MentorExperienceCard({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child:
              // progressIndicatorBuilder: (ctx, url, downloadProgress) =>
              //     CircularProgressIndicator(
              //   value: downloadProgress.progress,
              // ),
              // errorWidget: (context, url, error) => const Icon(Icons.error),
              Image.asset(
            "assets/images/icons/logo.png",
            width: 55,
            height: 55,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Founder & CEO",
              style: kLargeBoldTextStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w900),
            ),
            Text(
              "Ostello - Full time",
              style: kLargeTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500, color: kBlack),
            ),
            Text(
              "2020 - Present",
              style: kLargeTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              "Delhi, India",
              style: kLargeTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "Our Vision is to empower students.",
              style: kLargeTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
