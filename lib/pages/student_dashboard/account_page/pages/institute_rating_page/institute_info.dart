import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import './institute_reviews.dart';
import './pages/write_review.dart';
import './widgets/review_container.dart';
import '../../../../../models/institute.dart';
import '../../../../../models/review.dart';
import '../../../../../providers/review_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';

class InstituteInfo extends StatefulWidget {
  final Institute institute;

  const InstituteInfo({
    Key? key,
    required this.institute,
  }) : super(key: key);

  @override
  State<InstituteInfo> createState() => _InstituteInfoState();
}

class _InstituteInfoState extends State<InstituteInfo> {
  List<Review> reviews = [];
  bool startedPlaying = false;
  late VideoPlayerController? _controller;

  Widget _playControllerWidget = const Icon(
    Icons.play_arrow,
    color: Colors.white,
    size: 100.0,
    semanticLabel: 'Play',
  );

  @override
  void initState() {
    super.initState();

    if (widget.institute.videos.isEmpty) {
      _controller = null;
    } else {
      _controller = VideoPlayerController.network(
          '$mediaHost/${widget.institute.videos[0].key}')
        ..initialize().then(
          (_) {
            setState(() {
              _controller!.seekTo(
                const Duration(seconds: 0),
              );
            });
          },
        );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    reviews = context.watch<ReviewProvider>().reviews;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 185,
                  child: _controller != null && _controller!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(_controller!),
                              _myController(),
                            ],
                          ),
                        )
                      : widget.institute.images.isNotEmpty
                          ? Image.network(
                              "$mediaHost/${widget.institute.images[0].key}",
                            )
                          : Image.asset(
                              "assets/images/profile/institute_card_placeholder.png",
                            ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.institute.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              widget.institute.rating.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff777777),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  jsonDecode(widget.institute.description)[0],
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff777777),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${widget.institute.locations[0].line1}\n${widget.institute.locations[0].line2}\n${widget.institute.locations[0].area}\n${widget.institute.locations[0].city}\n${widget.institute.locations[0].state}\n${widget.institute.locations[0].pincode}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.institute.coursecategories.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Courses offered',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff777777),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text(
                            'JEE Mains',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'JEE Advance',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'NEET',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                const Text(
                  'Year of Establishment',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Color(0xff777777),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.institute.establishedyear.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.institute.studentsenrolled != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Students Enrolled',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color(0xff777777),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.institute.studentsenrolled.toString().trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Roboto',
                        color: Color(0xff263238),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        _controller?.pause();

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => WriteReviewPage(
                              instituteId: widget.institute.id,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 25),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: reviews.isNotEmpty
                      ? Column(
                          children: [
                            for (int i = 0; i < reviews.length; i++)
                              ReviewContainer(review: reviews[i]),
                            TextButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => InstituteReviewsPage(
                                    instituteId: widget.institute.id,
                                  ),
                                ),
                              ),
                              child: const Text("View More!"),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            "No Reviews",
                            style: TextStyle(color: kGray),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myController() {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: double.infinity,
          width: double.infinity,
          color: _controller!.value.isPlaying
              ? Colors.transparent
              : Colors.black26,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              child: _playControllerWidget,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _controller!.value.isPlaying
                ? {
                    _controller!.pause(),
                    setState(() {
                      startedPlaying = false;
                      _playControllerWidget = const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                        semanticLabel: 'Play',
                      );
                    }),
                  }
                : {
                    _controller!.play(),
                    setState(
                      () {
                        startedPlaying = true;
                        _playControllerWidget = const Icon(
                          Icons.pause,
                          size: 100.0,
                          color: Colors.transparent,
                          semanticLabel: 'Pause',
                        );
                      },
                    ),
                  };
          },
        ),
      ],
    );
  }
}
