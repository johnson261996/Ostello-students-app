import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './write_mentor_review_screen.dart';
import '../../../../../../providers/mentor_provider.dart';
import '../../../../../../utils/colours.dart';
import '../widgets/review_card.dart';

class MentorReviewsScreen extends StatefulWidget {
  final String id;

  const MentorReviewsScreen({
    Key? key,
    required this.id,
  }): super(key: key);

  @override
  State<MentorReviewsScreen> createState() => _MentorReviewsScreenState();
}

class _MentorReviewsScreenState extends State<MentorReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final mentorProvider = context.watch<MentorProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kBlack,
          ),
        ),
        title: const Text(
          "Review",
          style: TextStyle(
            fontSize: 20,
            color: kBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mentorProvider.reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(idx: index);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            WriteMentorReviewScreen(id: widget.id),
                      ),
                    ),
                    child: const Text(
                      "Write a review",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
