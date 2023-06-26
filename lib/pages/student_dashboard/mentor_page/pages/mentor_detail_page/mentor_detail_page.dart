import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ostello_mentor/pages/student_dashboard/mentor_page/pages/mentor_detail_page/widgets/review_tab.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import './session_selector.dart';
import './widgets/education_card.dart';
import './widgets/experience_card.dart';
import '../../../../../providers/mentor_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';

class MentorDetailPage extends StatefulWidget {
  final int index;

  const MentorDetailPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<MentorDetailPage> createState() => _MentorDetailPageState();
}

class _MentorDetailPageState extends State<MentorDetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tokensProvider = context.read<TokensProvider>();
    final mentorProvider = context.watch<MentorProvider>();

    final skillList = [
      '#Product Consulting',
      '#Android',
      '#Product Management',
      '#Cat Preparations',
      '#JEE',
      '#NEET',
      '#Case Study Competitions & Innovation',
      '#Android',
      '#Product Management',
      '#Cat Preparations',
      '#JEE',
      '#NEET',
    ];
    final int halfLength = (skillList.length / 2).ceil().toInt();
    final firstHalf = skillList.sublist(0, halfLength);
    final secondHalf = skillList.sublist(halfLength);
    final mentor = mentorProvider.mentors[widget.index];

    return Scaffold(
      backgroundColor: kPureWhite,
      body: Column(
        children: [
          SizedBox(
            height: 430,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/mentor/mentor_detail_bg.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: kPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: (size.width / 2) - 175,
                  bottom: 0,
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.only(
                      top: 55,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(0.0, 0.75),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          mentor.name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          mentor.specialization!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kBlack,
                            fontFamily: "Roboto",
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "${mentor.total_experience} years",
                                style: const TextStyle(
                                  color: kPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const [
                                  TextSpan(
                                    text: " Experience",
                                    style: TextStyle(
                                      color: kBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: mentor.followers_count.toString(),
                                style: const TextStyle(
                                  color: kPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const [
                                  TextSpan(
                                    text: " Followers",
                                    style: TextStyle(
                                      color: kBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return SimpleDialog(
                                  title: const Text(
                                    "Description",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: kBlack,
                                      fontFamily: "DMSans",
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 25,
                                  ),
                                  children: [
                                    Text(mentor.description!),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            mentor.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "DMSans",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const SessionSelector()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        const Color.fromRGBO(125, 35, 224, 1),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () => mentorProvider.followMentor(
                                  tokensProvider.tokens!.accessToken,
                                  widget.index,
                                ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: mentor.followed
                                      ? const Icon(Icons.check_rounded)
                                      : SvgPicture.asset(
                                          "assets/images/mentor/user_plus.svg",
                                          width: 14,
                                          height: 12,
                                          color: kPrimary,
                                          semanticsLabel: "Follow",
                                        ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Center(
                    child: mentor.avatar != null
                        ? Hero(
                            tag: "mentor_avatar_${widget.index}",
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                image: DecorationImage(
                                  image: FastCachedImageProvider(
                                    mentor.avatar!.url,
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            //   progressIndicatorBuilder:
                            //       (ctx, url, downloadProgress) =>
                            //           CircularProgressIndicator(
                            //     value: downloadProgress.progress,
                            //   ),
                            //   errorWidget: (context, url, error) =>
                            //       const Icon(Icons.error),
                            // ),
                          )
                        : Container(
                            width: 140,
                            height: 140,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/mentor/mentor_placeholder.svg",
                            ),
                          ),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: kPureWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: Scaffold(
                  backgroundColor: kPureWhite,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: kPureWhite,
                    toolbarHeight: 0,
                    flexibleSpace: Column(
                      children: [
                        Expanded(
                          child: TabBar(
                            labelColor: kBlack,
                            indicatorColor: kBlack,
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: [
                              const Tab(text: "Experience"),
                              Tab(
                                text: "Reviews (${mentor.reviews_count})",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: 'Work Experience',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Column(
                                      children: [
                                        for (var experience
                                            in mentor.experience)
                                          ExperienceCard(
                                              experience: experience),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: 'Education',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Column(
                                      children: [
                                        for (var experience
                                            in mentor.experience)
                                          educationcard(experience: experience),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'About ${mentor.name}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text:
                                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontFamily: 'DMSans',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: const TextSpan(
                                            text: 'Expert in',
                                            style: TextStyle(
                                              color: Color(0xff54769F),
                                              fontSize: 16,
                                              fontFamily: "DMSans",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                firstHalf.length,
                                                (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Chip(
                                                      label: Text(
                                                        firstHalf[index],
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff54769F),
                                                            fontFamily:
                                                                "DMsans",
                                                            fontSize: 12),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xffDADCE0),
                                                            width: 1),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                secondHalf.length,
                                                (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Chip(
                                                      label: Text(
                                                        secondHalf[index],
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff54769F),
                                                            fontFamily:
                                                                "DMsans",
                                                            fontSize: 12),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xffDADCE0),
                                                            width: 1),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const SessionSelector()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              125, 35, 224, 1),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              "Connect",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Roboto",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ReviewTab(
                          mentorId: '',
                        ),
                        // ExperienceTab(experiences: mentor.experience),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height * 0.65)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
