import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../apis/reviews.dart';
import '../../../../../providers/review_provider.dart';
import '../../../../../utils/colours.dart';
import 'widgets/review_container.dart';

class InstituteReviewsPage extends StatefulWidget {
  final String instituteId;

  const InstituteReviewsPage({
    Key? key,
    required this.instituteId,
  }) : super(key: key);

  @override
  State<InstituteReviewsPage> createState() => _InstituteReviewsPageState();
}

class _InstituteReviewsPageState extends State<InstituteReviewsPage> {
  Widget? alert;
  static const _pageSize = 10;
  late ReviewProvider reviewProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchPage(reviewProvider.reviews.length);
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
    reviewProvider = context.watch<ReviewProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        foregroundColor: kPrimary,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: reviewProvider.reviews.length + 1,
            itemBuilder: (ctx, idx) {
              if (idx < reviewProvider.reviews.length) {
                return ReviewContainer(
                  review: reviewProvider.reviews[idx],
                );
              } else if (alert != null) {
                return alert;
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int offset) async {
    try {
      if (alert != null) setState(() => alert = null);

      final newItems = await getInstituteReviews(
        widget.instituteId,
        _pageSize,
        offset,
      );

      final isLastPage = newItems.length < _pageSize;

      if (!isLastPage) {
        reviewProvider.appendToReviews = newItems;
      } else {
        setState(() {
          alert = const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "No more Reviews!",
                style: TextStyle(
                  color: kGray,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        });
      }
    } catch (error) {
      debugPrint(error.toString());
      if (alert != null) setState(() => alert = null);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Unknown error loading Reviews!"),
              TextButton(
                onPressed: () => _fetchPage(reviewProvider.reviews.length),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
