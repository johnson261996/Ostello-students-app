import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../../apis/schools.dart';
import '../../../../../providers/school_provider.dart';
import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';
import '../../widgets/dot_slider.dart';
import '../list_institute_page/list_institute_page.dart';
import 'school_form_page_2.dart';

class SchoolFormPage1 extends StatefulWidget {
  const SchoolFormPage1({Key? key}) : super(key: key);

  @override
  State<SchoolFormPage1> createState() => _SchoolFormPage1State();
}

class _SchoolFormPage1State extends State<SchoolFormPage1>
    with SingleTickerProviderStateMixin {
  static const _pageSize = 20;

  Widget? alert;
  String? _schoolQuery;
  String? _selectedSchool;

  bool _loading = false;
  bool _isPlaying = false;
  bool _dropDownExpanded = false;

  late SchoolProvider schoolProvider;
  late AnimationController _dropdownAnimationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchPage(schoolProvider.schools.length);
      }
    });

    _dropdownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    schoolProvider = context.watch<SchoolProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tokensProvider = context.read<TokensProvider>();
    final studentProvider = context.read<StudentProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'To personalize your ',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: 'Experience',
                      style: kLargeBoldTextStyle,
                    ),
                    TextSpan(
                      text: ', please select your school',
                      style: kLargeTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: const ListInstitutePage(),
                              ),
                            );
                          },
                          child: Text(
                            "School not Listed?",
                            style:
                                textTheme.bodySmall!.copyWith(color: kPrimary),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: ListTile(
                          onTap: () => setState(() {
                            _isPlaying = !_isPlaying;
                            _dropDownExpanded = !_dropDownExpanded;

                            _isPlaying
                                ? _dropdownAnimationController.reverse()
                                : _dropdownAnimationController.forward();
                          }),
                          title: Text(
                            _selectedSchool != null
                                ? _selectedSchool!
                                : "Select your School",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headlineMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          leading: AnimatedIcon(
                            color: kPrimary,
                            icon: AnimatedIcons.arrow_menu,
                            progress: _dropdownAnimationController,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AbsorbPointer(
                          absorbing: _dropDownExpanded ? false : true,
                          child: AnimatedOpacity(
                            opacity: _dropDownExpanded ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: AnimatedContainer(
                              height: _dropDownExpanded ? 180 : 0,
                              duration: const Duration(milliseconds: 500),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: TextField(
                                      onChanged: (val) {
                                        schoolProvider.getInitialSchools(val);
                                        setState(() => _schoolQuery = val);
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "School Name...",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount:
                                            schoolProvider.schools.length + 1,
                                        itemBuilder: (ctx, idx) {
                                          if (idx <
                                              schoolProvider.schools.length) {
                                            return ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              title: Text(
                                                schoolProvider
                                                    .schools[idx].schoolName,
                                                textScaleFactor: 1.2,
                                                style: textTheme.bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () {
                                                setState(
                                                  () {
                                                    _isPlaying = !_isPlaying;
                                                    _dropDownExpanded = false;

                                                    _isPlaying
                                                        ? _dropdownAnimationController
                                                            .reverse()
                                                        : _dropdownAnimationController
                                                            .forward();

                                                    _selectedSchool =
                                                        schoolProvider
                                                            .schools[idx]
                                                            .schoolName;
                                                  },
                                                );
                                              },
                                            );
                                          } else if (alert != null) {
                                            return alert;
                                          } else if (_loading) {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 30),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          } else {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Center(
                                                child: Text(
                                                  "No School/s found!",
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimary,
                    radius: 30,
                    child: IconButton(
                      onPressed: Navigator.of(context).pop,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: DotsSlider(total: 4, current: 1),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedSchool != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedSchool != null
                          ? () {
                              studentProvider.updateStudent(
                                "schoolName",
                                _selectedSchool!,
                                tokensProvider.tokens!.accessToken,
                              );

                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const SchoolFormPage2(),
                                ),
                              );
                            }
                          : null,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_forward_ios),
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

      final newItems = await getAllSchoolsAPI(
        _pageSize,
        _schoolQuery,
        offset,
      );

      final isLastPage = newItems.length < _pageSize;

      if (!isLastPage) {
        schoolProvider.appendToSchools = newItems;
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
                  "Error fetching Schools!",
                  style: TextStyle(
                    color: kGray,
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () => _fetchPage(schoolProvider.schools.length),
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
              const Text("Unknown error loading Schools!"),
              TextButton(
                onPressed: () => _fetchPage(schoolProvider.schools.length),
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
