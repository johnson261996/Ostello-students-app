import "dart:io";

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ostello_mentor/providers/token_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../apis/media.dart';
import '../../../../../models/media_object.dart';
import '../../../../../models/mentor.dart';
import '../../../../../providers/mentor_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/themes.dart';

class MentorAddEducation extends StatefulWidget {
  const MentorAddEducation({Key? key}): super(key: key);

  @override
  State<MentorAddEducation> createState() => _MentorAddEducationState();
}

class _MentorAddEducationState extends State<MentorAddEducation> {
  bool _loading = false;
  String? _school;
  String? _degree;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _grade;
  String? _fieldOfStudy;
  String? _description;
  String? _activitiesAndSocieties;
  MediaObject? _logo;
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final tokensProvider = context.read<TokensProvider>();
    final mentorProvider = context.read<MentorProvider>();
    final textTheme = Theme.of(context).textTheme;

    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (picked != null && picked != _startDate) {
        setState(() {
          _startDate = picked;
        });
        if (picked != _endDate) {
          setState(() {
            _endDate = picked;
          });
        }
      }
    }

    String startDateString =
        _startDate != null ? DateFormat.yMMMd().format(_startDate!) : '';
    String endDateString =
        _endDate != null ? DateFormat.yMMMd().format(_endDate!) : '';
    String combinedDates = '$startDateString - $endDateString';

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: kPrimary,
                radius: 20,
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  color: kWhite,
                  iconSize: 15,
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add education",
                        style: textTheme.headlineLarge?.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "* Indicates required",
                        style: textTheme.bodySmall!
                            .copyWith(color: kGray, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'School *',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _school = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: Boston University",
                              hintStyle: textTheme.bodySmall,
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Degree *',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _degree = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: Bachelor's",
                              hintStyle: textTheme.bodySmall,
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Field of study *',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _fieldOfStudy = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Ex: Buisness",
                              hintStyle: textTheme.bodySmall,
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGray),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _startDate == null
                                      ? 'Select Start date'
                                      : DateFormat.yMMMd().format(_startDate!),
                                  style: textTheme.bodySmall,
                                ),
                                IconButton(
                                  onPressed: _selectDate,
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date (or expected)',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGray),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _endDate == null
                                      ? 'Select End Date'
                                      : DateFormat.yMMMd().format(_endDate!),
                                  style: textTheme.bodySmall,
                                ),
                                IconButton(
                                  onPressed: _selectDate,
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add University Logo',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });

                                XFile? logo = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (logo != null) {
                                  final result = await getSignedUploadURL(
                                    logo.name.split(".").last,
                                  );

                                  String? uploadETag = await uploadFile(
                                    result["urls"]['0'],
                                    logo.path,
                                  );

                                  if (uploadETag != null) {
                                    bool uploaded = await completeFileUpload(
                                      result["uploadId"],
                                      result["key"],
                                      [
                                        {
                                          "PartNumber": 1,
                                          "ETag": uploadETag,
                                        }
                                      ],
                                    );

                                    if (uploaded) {
                                      debugPrint("${result["key"]}: $uploaded");

                                      setState(() {
                                        _logo = MediaObject(
                                          key: result["key"],
                                          url: "$mediaHost/${result["key"]}",
                                        );

                                        _selectedFile = logo;
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Error uploading avatar!"),
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Error uploading avatar!"),
                                      ),
                                    );
                                  }
                                }

                                setState(() {
                                  _loading = false;
                                });
                              },
                              child: _selectedFile == null
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      size: 30,
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        File(_selectedFile!.path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activities & Societies',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _activitiesAndSocieties = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText:
                                  "Ex: Alpha Phi Omega, Marching Band, Volleyball",
                              hintStyle: textTheme.bodySmall,
                              contentPadding:
                                  const EdgeInsets.only(bottom: 80, left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: kLargeTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                _description = val;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "",
                              hintStyle: textTheme.bodySmall,
                              contentPadding:
                                  const EdgeInsets.only(bottom: 80, left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final mentorEducation = MentorEducation(
                          logo: _logo,
                          school: _school!,
                          period: combinedDates,
                          degree: _degree!,
                          description: _description,
                          activitiesAndSocieties: _activitiesAndSocieties,
                          fieldOfStudy: _fieldOfStudy!,
                          grade: _grade!,
                          skills: [],
                        );

                        mentorProvider.updateMentor(
                          "education",
                          mentorEducation,
                          tokensProvider.tokens!.accessToken,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
