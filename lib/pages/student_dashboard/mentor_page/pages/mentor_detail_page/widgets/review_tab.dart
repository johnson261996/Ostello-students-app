import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './review_card.dart';
import '../../../../../../apis/mentor.dart';
import '../../../../../../providers/mentor_provider.dart';
import '../../../../../../utils/colours.dart';
import '../pages/mentor_reviews_screen.dart';
import '../pages/write_mentor_review_screen.dart';

class ReviewTab extends StatefulWidget {
  final String mentorId;

  const ReviewTab({
    Key? key,
    required this.mentorId,
  }): super(key: key);

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  Widget? alert;
  bool _loading = false;
  static const _pageSize = 10;
  late MentorProvider mentorProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchPage(mentorProvider.reviews.length);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    mentorProvider = context.watch<MentorProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: mentorProvider.reviews.length + 1,
        itemBuilder: (ctx, idx) {
          if (idx < mentorProvider.reviews.length) {
            return ReviewCard(idx: idx);
          } else if (alert != null) {
            return alert;
          } else if (_loading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          WriteMentorReviewScreen(id: widget.mentorId),
                    ),
                  ),
                  child: const Text(
                    "Write Review!",
                    style: TextStyle(
                      color: kGray,
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _fetchPage(int offset) async {
    setState(() {
      _loading = true;
    });

    try {
      if (alert != null) setState(() => alert = null);

      final newItems = await getMentorReviewsAPI(
        widget.mentorId,
        _pageSize,
        offset,
      );

      final isLastPage = newItems.length < _pageSize;

      if (!isLastPage) {
        mentorProvider.appendToMentorReviews = newItems;
      }

      setState(() {
        _loading = false;
      });
    } catch (error) {
      if (alert != null) {
        setState(() => alert = null);
      } else {
        setState(() {
          alert = Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MentorReviewsScreen(id: widget.mentorId),
                  ),
                ),
                child: const Text(
                  "See More!",
                  style: TextStyle(
                    color: kGray,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Unknown error loading Reviews!"),
              TextButton(
                onPressed: () => _fetchPage(mentorProvider.reviews.length),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );

      setState(() {
        _loading = false;
      });
    }
  }
}
