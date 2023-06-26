import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/mentor_provider.dart';
import '../../../../../../providers/token_provider.dart';
import '../../../../../../utils/colours.dart';

class WriteMentorReviewScreen extends StatefulWidget {
  final String id;

  const WriteMentorReviewScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<WriteMentorReviewScreen> createState() =>
      _WriteMentorReviewScreenState();
}

class _WriteMentorReviewScreenState extends State<WriteMentorReviewScreen> {
  int _rating = 3;
  String _review = "";
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mentorProvider = context.read<MentorProvider>();
    String accessToken = context.read<TokensProvider>().tokens!.accessToken;

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
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Write review",
          style: TextStyle(
            fontSize: 20,
            color: kBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kPureWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 22,
                      color: kGray,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      minLines: 2,
                      maxLines: 10,
                      initialValue: _review,
                      onSaved: (val) {
                        if (val != null) {
                          setState(() {
                            _review = val;
                          });
                        }
                      },
                      validator: (val) {
                        if (val == "" || val == null) {
                          return "Enter a valid Review";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        label: Text(
                          "Write your review",
                          style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 22,
                          color: kGray,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 150,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                              child: index < _rating
                                  ? const Icon(
                                       Icons.star_outlined,
                                      color: Colors.orange,
                                       size: 30,
                                    )
                                  : const Icon(
                                      Icons.star_outlined,
                                       size: 30,
                                     color: kLightGray,
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        mentorProvider
                            .postMentorReview(
                          accessToken,
                          _review,
                          _rating,
                          widget.id,
                        )
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "DMSans",
                        ),
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
