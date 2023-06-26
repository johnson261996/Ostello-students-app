import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import './sections/academic_data_section.dart';
import './sections/institute_details_section.dart';
import './sections/language_preference_section.dart';
import '../../../../../apis/media.dart';
import '../../../../../providers/student_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _firstName;
  String? _lastName;
  String? _description;
  String? _email;
  String? _phoneNumber;
  PRONOUNS? _gender;
  String? _city;
  int? _pinCode;

  bool _isChanged = false;

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey();

  late TokensProvider tokensProvider;
  late StudentProvider studentProvider;

  @override
  void didChangeDependencies() {
    tokensProvider = context.read<TokensProvider>();
    studentProvider = context.watch<StudentProvider>();
    super.didChangeDependencies();
  }

  Future<void> _pickImage() async {
    XFile? avatar = await _picker.pickImage(source: ImageSource.gallery);

    if (avatar != null) {
      final result = await getSignedUploadURL(
        avatar.name.split(".").last,
      );

      String? uploadETag = await uploadFile(
        result["urls"]['0'],
        avatar.path,
      );

      if (uploadETag != null) {
        bool uploaded =
            await completeFileUpload(result["uploadId"], result["key"], [
          {"PartNumber": 1, "ETag": uploadETag}
        ]);

        if (uploaded) {
          studentProvider.updateStudent(
            "avatar",
            result["key"],
            tokensProvider.tokens!.accessToken,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error uploading avatar!"),
            ),
          );
        }
      }
    }
  }

  void updateIsChanged() {
    setState(() {
      _isChanged = !_isChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: kPureWhite,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            color: kBlack,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: kPureWhite,
        foregroundColor: kPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: media.height,
          width: media.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${studentProvider.student.firstName} ${studentProvider.student.lastName}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: 'Profile Strength : ',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text:
                                        '${studentProvider.profileStrengthCategory} ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${studentProvider.profileStrength}%",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Roboto',
                                      color: Color(0xffFF0000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              height: 10,
                              width: 250,
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, idx) => Container(
                                  height: 8,
                                  width: 44,
                                  margin: const EdgeInsets.only(right: 1),
                                  decoration: BoxDecoration(
                                    color: idx <
                                            studentProvider
                                                .profileStrengthFilledBlocks
                                        ? studentProvider.profileStrengthColor
                                        : kLightGray,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: _pickImage,
                              child: studentProvider.student.avatar != null
                                  ? CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                        "$mediaHost/${studentProvider.student.avatar!.key}",
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                          "assets/images/homepage/avatar.png"),
                                    ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              child: InkWell(
                                onTap: _pickImage,
                                child: Text(
                                  'Add photo',
                                  style: textTheme.bodySmall!.copyWith(
                                      color: kPrimary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 15,
                            bottom: 10,
                          ),
                          child: ListView(
                            children: [
                              Form(
                                key: _key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Personal information",
                                      style: textTheme.headlineMedium,
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.firstName,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _firstName = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid Name!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.lastName,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "Last Name",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _lastName = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid Name!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.description,
                                      maxLength: 120,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "Short Bio",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _description = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid Bio!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.email,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _email = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid Email!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.phoneNumber,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "Phone Number",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            val.length > 9 &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _phoneNumber = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value ==
                                            studentProvider
                                                .student.phoneNumber) {
                                          return null;
                                        }

                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length > 9) {
                                          return 'Please enter a valid Phone Number!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Gender",
                                          style: textTheme.bodySmall!.copyWith(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 50),
                                        DropdownButton<PRONOUNS>(
                                          value:
                                              studentProvider.student.gender ==
                                                      "male"
                                                  ? PRONOUNS.male
                                                  : (studentProvider
                                                              .student.gender ==
                                                          "female"
                                                      ? PRONOUNS.female
                                                      : PRONOUNS.others),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: PRONOUNS.values
                                              .map((PRONOUNS pronoun) {
                                            return DropdownMenuItem(
                                              value: pronoun,
                                              child: Text(pronoun
                                                  .toString()
                                                  .split(".")[1]),
                                            );
                                          }).toList(),
                                          onChanged: (PRONOUNS? newValue) {
                                            setState(() {
                                              if (_isChanged != true) {
                                                updateIsChanged();
                                              }

                                              _gender = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.city,
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "City",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(() => _city = val);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid City!';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      initialValue:
                                          studentProvider.student.pinCode !=
                                                  null
                                              ? studentProvider.student.pinCode
                                                  .toString()
                                              : "",
                                      style: textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: "Pin Code",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            color: kLightGray,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _isChanged != true) {
                                          updateIsChanged();
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val != null) {
                                          setState(
                                              () => _pinCode = int.parse(val));
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a valid Pin Code!';
                                        }

                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const AcademicDataSection(),
                              const SizedBox(height: 20),
                              const LanguagePreferenceSection(),
                              const SizedBox(height: 20),
                              const InstitutionDetailsSection(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isChanged
                          ? () {
                              updateIsChanged();

                              if (_key.currentState != null &&
                                  _key.currentState!.validate()) {
                                _key.currentState!.save();

                                if (_firstName != null &&
                                    _firstName !=
                                        studentProvider.student.firstName) {
                                  studentProvider.updateStudent(
                                    "firstName",
                                    _firstName!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_lastName != null &&
                                    _lastName !=
                                        studentProvider.student.lastName) {
                                  studentProvider.updateStudent(
                                    "lastName",
                                    _lastName!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_description != null &&
                                    _description !=
                                        studentProvider.student.description) {
                                  studentProvider.updateStudent(
                                    "description",
                                    _description!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_email != null &&
                                    _email != studentProvider.student.email) {
                                  studentProvider.updateStudent(
                                    "email",
                                    _email!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_phoneNumber != null &&
                                    _phoneNumber !=
                                        studentProvider.student.phoneNumber) {
                                  studentProvider.updateStudent(
                                    "phoneNumber",
                                    _phoneNumber!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_gender != null &&
                                    _gender.toString().split(".")[1] !=
                                        studentProvider.student.gender) {
                                  studentProvider.updateStudent(
                                    "gender",
                                    _gender.toString().split(".")[1],
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_city != null &&
                                    _city != studentProvider.student.city) {
                                  studentProvider.updateStudent(
                                    "city",
                                    _city!,
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }

                                if (_pinCode != null &&
                                    _pinCode.toString() !=
                                        studentProvider.student.pinCode) {
                                  studentProvider.updateStudent(
                                    "pinCode",
                                    _pinCode.toString(),
                                    tokensProvider.tokens!.accessToken,
                                  );
                                }
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 30,
                        ),
                      ),
                      child: const Text("Update"),
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
