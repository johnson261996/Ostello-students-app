import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/mentor_provider.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/formatters.dart';

class ReviewCard extends StatelessWidget {
  final int idx;

  const ReviewCard({
    Key? key,
    required this.idx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final review = context.watch<MentorProvider>().reviews[idx];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.studentname,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.rating,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star_outlined,
                        size: 20,
                        color: Colors.orangeAccent,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              review.reviewtext,
              style: const TextStyle(
                letterSpacing: 0.14,
                // color: Color.fromARGB(255, 110, 110, 110),
                fontSize: 12,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              const Text(
                                "Helpful?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 12,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Yes (${review.upvotes})",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 155, 155, 155),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 1,
                                color: const Color.fromARGB(255, 167, 167, 167),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 155, 155, 155),
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          dateFormatter(review.publishedon),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 155, 155, 155),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Row(children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                color: kBlack,
                                size: 15,
                              ),
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                color: Color.fromARGB(255, 66, 66, 66),
                                fontSize: 12,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.comment,
                                  color: kBlack,
                                  size: 15,
                                ),
                              ),
                              Text(
                                "Comment",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 78, 78, 78),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
