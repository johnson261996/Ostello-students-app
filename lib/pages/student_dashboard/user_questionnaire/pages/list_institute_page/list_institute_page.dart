import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/school_provider.dart';
import '../../../../../providers/token_provider.dart';
import '../../../../../utils/colours.dart';
import '../../../../../utils/themes.dart';

class ListInstitutePage extends StatefulWidget {
  const ListInstitutePage({Key? key}) : super(key: key);

  @override
  State<ListInstitutePage> createState() => _ListInstitutePageState();
}

class _ListInstitutePageState extends State<ListInstitutePage> {
  String? _name;
  String? _area;
  int? _pinCode;

  bool _nameFilled = false;
  bool _areaFilled = false;
  bool _pinCodeFilled = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final schoolProvider = context.read<SchoolProvider>();
    final tokensProvider = context.read<TokensProvider>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'List your ',
                        style: kLargeTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text: 'School/College',
                        style: kLargeBoldTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Name Required!";
                            } else if (val.length < 3) {
                              return "Enter a valid Name!";
                            }

                            return null;
                          },
                          onSaved: (val) {
                            if (val != null) {
                              setState(() => _name = val);
                            }
                          },
                          onChanged: (val) {
                            if (val.isNotEmpty && val.length >= 3) {
                              if (_nameFilled != true) {
                                setState(() => _nameFilled = true);
                              }
                            } else {
                              if (_nameFilled != false) {
                                setState(() => _nameFilled = false);
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kPrimary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kLightGray,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        AnimatedOpacity(
                          opacity: _nameFilled ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Locality Required!";
                              } else if (val.length < 3) {
                                return "Enter a valid Locality!";
                              }

                              return null;
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(() => _area = val);
                              }
                            },
                            onChanged: (val) {
                              if (val.isNotEmpty && val.length >= 3) {
                                if (_areaFilled != true) {
                                  setState(() => _areaFilled = true);
                                }
                              } else {
                                if (_areaFilled != false) {
                                  setState(() => _areaFilled = false);
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Area/Locality",
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kLightGray,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        AnimatedOpacity(
                          opacity: _areaFilled ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || int.parse(val) == 0) {
                                return "Pin Code Required!";
                              } else if (val.length < 3) {
                                return "Enter a valid Locality!";
                              }

                              return null;
                            },
                            onSaved: (val) {
                              if (val != null) {
                                setState(() => _pinCode = int.parse(val));
                              }
                            },
                            onChanged: (val) {
                              if (val.isNotEmpty && val.length == 6) {
                                if (_pinCodeFilled != true) {
                                  setState(() => _pinCodeFilled = true);
                                }
                              } else {
                                if (_pinCodeFilled != false) {
                                  setState(() => _pinCodeFilled = false);
                                }
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Pin Code",
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kLightGray,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  CircleAvatar(
                    backgroundColor: _pinCodeFilled ? kPrimary : kLightGray,
                    radius: 30,
                    child: IconButton(
                      onPressed: _pinCodeFilled
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                schoolProvider
                                    .listInstitute(
                                  tokensProvider.tokens!.accessToken,
                                  _name!,
                                  _area!,
                                  _pinCode!,
                                )
                                    .then((listed) {
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                          : null,
                      color: kWhite,
                      iconSize: 20,
                      icon: const Icon(Icons.check_rounded, size: 25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
