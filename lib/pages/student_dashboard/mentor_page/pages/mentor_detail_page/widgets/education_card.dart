import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../models/mentor.dart';
import '../../../../../../utils/colours.dart';

class educationcard extends StatelessWidget {
  final MentorExperience experience;

  const educationcard({
    Key? key,
    required this.experience,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: experience.logo != null
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    image: DecorationImage(
                      image: FastCachedImageProvider(experience.logo!.url),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                )
              // progressIndicatorBuilder: (ctx, url, downloadProgress) =>
              //     CircularProgressIndicator(
              //   value: downloadProgress.progress,
              // ),
              // errorWidget: (context, url, error) => const Icon(Icons.error),
              : SvgPicture.asset(
                  "assets/images/mentor/experience_placeholder.svg",
                  color: kPrimary,
                  width: 30,
                  height: 30,
                ),
        ),
        const SizedBox(width: 20),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "IIM, Ahmedabad",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "DMsans",
                fontSize: 14,
              ),
            ),
            Text(
              "MBA",
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: "DMsans",
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "2020 - 2022",
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: "DMsans",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
