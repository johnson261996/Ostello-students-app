import "dart:io";

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../apis/media.dart';
import '../../../../providers/mentor_provider.dart';
import '../../../../utils/colours.dart';
import '../../../student_dashboard/user_questionnaire/widgets/dot_slider.dart';
import 'mentor_location_form.dart';

class PickAvatarForm extends StatefulWidget {
  const PickAvatarForm({Key? key}): super(key: key);

  @override
  State<PickAvatarForm> createState() => _PickAvatarFormState();
}

class _PickAvatarFormState extends State<PickAvatarForm> {
  bool _loading = false;
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  late MentorProvider _mentorProvider;

  @override
  void didChangeDependencies() {
    _mentorProvider = context.watch<MentorProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (_loading)
                const SizedBox(
                  height: 2,
                  child: LinearProgressIndicator(),
                )
              else
                const SizedBox(height: 2),
              const SizedBox(height: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ready to personalize your profile? ",
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      "Let's add a picture that captures your unique style!",
                      style: textTheme.headlineSmall!.copyWith(
                        color: kGray,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              _loading = true;
                            });

                            XFile? avatar = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );

                            if (avatar != null) {
                              final result = await getSignedUploadURL(
                                avatar.name.split(".").last,
                              );

                              String? uploadETag = await uploadFile(
                                result["urls"]['0'],
                                avatar.path,
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

                                  _mentorProvider.updateMentor(
                                    "avatar",
                                    result["key"],
                                  );

                                  setState(() {
                                    _selectedFile = avatar;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Error uploading avatar!"),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Error uploading avatar!"),
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
                    ),
                  ],
                ),
              ),
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
                    child: DotsSlider(total: 8, current: 5),
                  ),
                  CircleAvatar(
                    backgroundColor:
                        _selectedFile != null ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _selectedFile != null
                          ? () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const MentorLocationForm(),
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
}
