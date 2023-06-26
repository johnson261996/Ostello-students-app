import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './institute_info.dart';
import './qr_scanner.dart';
import '../../../../../providers/institute_provider.dart';
import '../../../../../providers/review_provider.dart';
import '../../../../../utils/colours.dart';

class FindInstitute extends StatefulWidget {
  const FindInstitute({Key? key}) : super(key: key);

  @override
  State<FindInstitute> createState() => _FindInstituteState();
}

class _FindInstituteState extends State<FindInstitute> {
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reviewsProvider = context.read<ReviewProvider>();
    final instituteProvider = context.watch<InstituteProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        title: const Text(
          'Rate Your institute',
          style: TextStyle(
            fontSize: 24,
            color: kBlack,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: kPureWhite,
        foregroundColor: kPrimary,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (builder) => const QrScannerPage(),
              ),
            ),
            icon: const Icon(
              Icons.qr_code,
              size: 30,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _queryController,
                onChanged: (val) {
                  if (val != "") {
                    instituteProvider.getInstitutes(val);
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Type or Paste Institute link',
                  border: OutlineInputBorder(),
                ),
              ),
              Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: instituteProvider.institutes.length,
                  itemBuilder: (BuildContext context, int index) {
                    reviewsProvider.getInstitutesReviews(
                        instituteProvider.institutes[index].id);

                    return GestureDetector(
                      onTap: () {
                        reviewsProvider.getInstitutesReviews(
                            instituteProvider.institutes[index].id);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => InstituteInfo(
                              institute: instituteProvider.institutes[index],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          instituteProvider.institutes[index].name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Image.asset(
                          'assets/images/profile/arrow-up-left.png',
                          scale: 2.4,
                          color: const Color(0xff263238),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
