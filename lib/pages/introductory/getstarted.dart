import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/otps.dart';
import '../../pages/introductory/widgets/verify_otp.dart';
import '../../utils/colours.dart';
import '../mentor_dashboard/mentor_signup.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

Widget _buildDropdownItem(Country country) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8),
        Text(
          country.phoneCode,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

class _GetStartedPageState extends State<GetStartedPage> {
  bool _email = false;
  bool _submit = false;
  bool _loading = false;

  String? _phone;
  String? _emailAddress;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: kPureWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      "Get Started",
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Please enter your mobile number",
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 25),
                    if (_email)
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: kPrimary,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: kLightGray,
                              width: 2,
                            ),
                          ),
                        ),
                        onSaved: (val) {
                          setState(() => _emailAddress = val);
                        },
                        onChanged: (val) {
                          if (val.isNotEmpty && val.length > 9) {
                            setState(() => _submit = true);
                          } else if (_submit != false) {
                            setState(() => _submit = false);
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains("@")) {
                            return 'Please enter a valid Email!';
                          }

                          return null;
                        },
                      )
                    else
                      Row(
                        children: [
                          Container(
                            width: 110,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: CountryPickerDropdown(
                              initialValue: 'IN',
                              isExpanded: true,
                              itemBuilder: _buildDropdownItem,
                              itemFilter: (c) => c.phoneCode.length < 4,
                              priorityList: [
                                CountryPickerUtils.getCountryByIsoCode('GB'),
                                CountryPickerUtils.getCountryByIsoCode('CN'),
                              ],
                              sortComparator: (Country a, Country b) =>
                                  a.isoCode.compareTo(b.isoCode),
                              onValuePicked: (Country country) {},
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: kLightGray,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onSaved: (val) {
                                if (val != null && val.isNotEmpty) {
                                  setState(() => _phone = val);
                                }
                              },
                              onChanged: (val) {
                                if (val.isNotEmpty && val.length > 9) {
                                  setState(() => _submit = true);
                                } else if (_submit != false) {
                                  setState(() => _submit = false);
                                }
                              },
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10) {
                                  return 'Please enter a valid Phone Number!';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submit
                                ? (_loading
                                    ? null
                                    : () {
                                        setState(() {
                                          _loading = true;
                                        });

                                        if (_key.currentState != null &&
                                            _key.currentState!.validate()) {
                                          _key.currentState!.save();

                                          generateOtp(
                                            _phone!,
                                            _emailAddress,
                                          ).then((otpSent) {
                                            if (otpSent) {
                                              Navigator.of(context).push(
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: VerifyOTPPage(
                                                    phoneNumber:
                                                        _phone.toString(),
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        }

                                        setState(() {
                                          _loading = false;
                                        });
                                      })
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 30,
                              ),
                            ),
                            child: const Text("Send OTP"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Divider(
                            color: kPrimary,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "or",
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(width: 15),
                        const SizedBox(
                          width: 100,
                          child: Divider(
                            color: kPrimary,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() => _email = !_email);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGray),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Icon(
                              _email ? Icons.phone : Icons.email_outlined,
                              color: kPrimary,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const MentorSignUp(),
                        ),
                      ),
                      child: const Text(
                        "Signup as a Mentor",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      "By continuing, you agree to our",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await launchUrl(
                              Uri(
                                scheme: "https",
                                host: "www.ostello.co.in",
                                path: "terms/",
                              ),
                            );
                          },
                          child: const Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: kBodyTextColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () async {
                            await launchUrl(
                              Uri(
                                scheme: "https",
                                host: "www.ostello.co.in",
                                path: "privacy/",
                              ),
                            );
                          },
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: kBodyTextColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
