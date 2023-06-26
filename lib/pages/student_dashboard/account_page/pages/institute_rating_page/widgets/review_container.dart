import 'package:flutter/material.dart';

import '../../../../../../models/review.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/constants.dart';

class ReviewContainer extends StatelessWidget {
  final Review review;

  const ReviewContainer({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              review.user.avatar == null
                  ? const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage("assets/images/homepage/avatar.png"),
                    )
                  : CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        "$mediaHost/${review.user.avatar!.key}",
                      ),
                    ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < review.rating; i++)
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.orangeAccent,
                              ),
                            for (int i = 0; i < 5 - review.rating; i++)
                              const Icon(
                                Icons.star_border,
                                size: 15,
                                color: Colors.orangeAccent,
                              ),
                          ],
                        ),
                        Text(
                          "${review.publishedon.day}/${review.publishedon.month}/${review.publishedon.year}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            review.reviewtext,
                            softWrap: false,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              color: kBlack,
                              fontFamily: 'Roboto',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${review.user.firstName} ${review.user.lastName}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: kBlack,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
