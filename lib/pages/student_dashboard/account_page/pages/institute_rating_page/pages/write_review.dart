import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../../apis/media.dart';
import '../../../../../../apis/reviews.dart';
import '../../../../../../providers/review_provider.dart';
import '../../../../../../providers/token_provider.dart';
import '../../../../../../utils/colours.dart';
import '../../../../../../utils/constants.dart';

class WriteReviewPage extends StatefulWidget {
  final String instituteId;

  const WriteReviewPage({
    Key? key,
    required this.instituteId,
  }) : super(key: key);

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  double _rating = 3;
  List<XFile> _images = [];

  // List<XFile> _videos = [];

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final reviewProvider = context.read<ReviewProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        elevation: 1,
        foregroundColor: kPrimary,
        backgroundColor: kWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate your coaching institute',
              style: TextStyle(
                fontSize: 21,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Color(0xff263238),
              ),
            ),
            const SizedBox(height: 10),
            RatingBar(
              initialRating: 3,
              ratingWidget: RatingWidget(
                empty: const Icon(
                  Icons.star_border,
                  color: Colors.orangeAccent,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.orangeAccent,
                ),
                full: const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
              ),
              onRatingUpdate: (value) {
                setState(() {
                  _rating = value;
                });
              },
              // glow: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'Add institute photos',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'You can add up-to 5 photos',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                color: Color(0xff929597),
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    _images.length < 5 ? _images.length + 1 : _images.length,
                itemBuilder: (context, index) {
                  if (index < _images.length) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      width: 100,
                      child: Image.asset(_images[index].path),
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final imgs = await _picker.pickMultiImage(
                            requestFullMetadata: false);
                        setState(() => _images = imgs);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: kLightGray,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: kBlack,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            // const SizedBox(height: 20),
            // const Text(
            //   'Add institute videos',
            //   style: TextStyle(
            //     fontSize: 14,
            //     fontFamily: 'Roboto',
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // const Text(
            //   'You can add up-to 5 videos',
            //   style: TextStyle(
            //     fontSize: 12,
            //     fontFamily: 'Roboto',
            //     fontWeight: FontWeight.w300,
            //     color: Color(0xff929597),
            //   ),
            // ),
            // const SizedBox(height: 5),
            // SizedBox(
            //   height: 100,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     shrinkWrap: true,
            //     itemCount: _images.length + 1,
            //     itemBuilder: (context, index) {
            //       if (index < _images.length) {
            //         return Container(
            //           margin: const EdgeInsets.all(5),
            //           width: 100,
            //           child: VideoPlayer(),
            //         );
            //       } else {
            //         return InkWell(
            //           onTap: () async {
            //             final vid = await _picker.pickVideo(
            //                 source: ImageSource.gallery);
            //
            //             if (vid != null) {
            //               setState(() => _videos.add(vid));
            //             }
            //           },
            //           child: Container(
            //             height: 100,
            //             width: 100,
            //             color: kLightGray,
            //             child: const Center(
            //               child: Icon(Icons.add),
            //             ),
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Feedback',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              minLines: 5,
              maxLines: null,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: 'Write a feedback about your institute...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  color: Color(0xff929597),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    List fileToUpload = [];

                    for (int i = 0; i < _images.length; i++) {
                      final res = await getSignedUploadURL(
                        _images[i].name.split(".").last,
                      );

                      fileToUpload.add(res);
                    }

                    List uploadedImages = [];

                    for (int i = 0; i < fileToUpload.length; i++) {
                      String? uploadETag = await uploadFile(
                        fileToUpload[i]["urls"]['0'],
                        _images[i].path,
                      );

                      if (uploadETag != null) {
                        bool uploaded = await completeFileUpload(
                            fileToUpload[i]["uploadId"],
                            fileToUpload[i]["key"], [
                          {"PartNumber": 1, "ETag": uploadETag}
                        ]);

                        if (uploaded) {
                          uploadedImages.add({
                            "key": fileToUpload[i]["key"],
                            "url": "$mediaHost/${fileToUpload[i]["key"]}",
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error uploading avatar!"),
                            ),
                          );
                        }
                      }
                    }

                    dynamic review = {
                      "rating": _rating,
                      "images": uploadedImages,
                      "instituteid": widget.instituteId,
                      "reviewtext": _feedbackController.text,
                    };

                    bool posted = await addReview(
                      tokensProvider.tokens!.accessToken,
                      review,
                    );

                    if (posted) {
                      reviewProvider
                          .getInstitutesReviews(widget.instituteId)
                          .then((_) {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
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
