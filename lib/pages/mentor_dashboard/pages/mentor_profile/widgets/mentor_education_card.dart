import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';

class MentorEducationCard extends StatelessWidget {
  const MentorEducationCard({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
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
              SvgPicture.asset(
            "assets/images/mentor/experience_placeholder.svg",
            color: kPrimary,
            width: 25,
            height: 25,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "IIM, Ahmedabad",
              style: kLargeBoldTextStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w900),
            ),
            Text(
              "MBA",
              style: kLargeTextStyle.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w500, color: kBlack),
            ),
            Text(
              "2020 - 2022",
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
