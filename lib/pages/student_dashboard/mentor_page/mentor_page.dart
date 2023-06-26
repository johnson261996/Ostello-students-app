import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import './pages/mentor_detail_page/mentor_detail_page.dart';
import './widgets/mentor_card.dart';
import '../../../apis/mentor.dart';
import '../../../providers/mentor_provider.dart';
import '../../../providers/student_provider.dart';
import '../../../providers/token_provider.dart';
import '../../../utils/colours.dart';

class MentorPage extends StatefulWidget {
  const MentorPage({Key? key}): super(key: key);

  @override
  State<MentorPage> createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> {
  Widget? alert;
  bool _loading = false;
  static const _pageSize = 10;
  late MentorProvider mentorProvider;
  late TokensProvider tokensProvider;
  late StudentProvider studentProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchPage(mentorProvider.mentors.length);
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
    tokensProvider = context.watch<TokensProvider>();
    studentProvider = context.watch<StudentProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Hi ",
                          style: const TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                              text: "${studentProvider.student.firstName}!",
                              style: const TextStyle(
                                fontSize: 18,
                                color: kBlack,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Find your fav Mentor",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notification_add_outlined,
                      color: Colors.purple,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            fillColor: Colors.white,
                            hintText: "Search for mentor",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 100),
                          child: Text(
                            "Get connected with +500k best Mentors and get solution of all queries",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            maximumSize: const Size.fromWidth(120),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Connect",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: kPureWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              FaIcon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                color: kPureWhite,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/mentor/search_mentor_bg.png",
                    width: 137,
                  ),
                ),
              ]),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Top Mentors",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "More",
                        style: TextStyle(
                          fontSize: 14,
                          color: kGray,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: mentorProvider.mentors.length + 1,
                      separatorBuilder: (ctx, idx) => const SizedBox(width: 20),
                      itemBuilder: (ctx, idx) {
                        if (idx < mentorProvider.mentors.length) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  mentorProvider.getInitialMentorReviews(
                                    mentorProvider.mentors[idx].id!,
                                  );

                                  return MentorDetailPage(index: idx);
                                },
                              ),
                            ),
                            child: MentorCard(index: idx),
                          );
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
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                "No Mentors for Now!",
                                style: TextStyle(
                                  color: kGray,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int offset) async {
    setState(() {
      _loading = true;
    });

    try {
      if (alert != null) setState(() => alert = null);

      final newItems = await getAllMentorsAPI(
        tokensProvider.tokens!.accessToken,
        _pageSize,
        offset,
      );

      final isLastPage = newItems.length < _pageSize;

      if (!isLastPage) {
        mentorProvider.appendToMentors = newItems;
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
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Error fetching Mentors!",
                  style: TextStyle(
                    color: kGray,
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () => _fetchPage(studentProvider.posts.length),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Unknown error loading Mentors!"),
              TextButton(
                onPressed: () => _fetchPage(studentProvider.posts.length),
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
