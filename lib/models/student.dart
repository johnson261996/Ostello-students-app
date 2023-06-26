import 'dart:convert';

import './media_object.dart';

class Student {
  String? id;
  String? firstName;
  String? lastName;
  String? description;
  String? email;
  String? dob;
  String? gender;
  String? phoneNumber;
  MediaObject? avatar;

  String? schoolName;
  String? grade;
  String? stream;
  String? streamDetail;
  String? ambition;
  String? targetExam;

  String? languageModeTeaching;
  String? languageModeBooks;

  String? currentInstitute;
  String? coachingMode;

  String? country;
  String? state;
  String? city;
  String? area;
  String? pinCode;

  Student.empty();

  Student(
    this.id,
    this.avatar,
    this.firstName,
    this.lastName,
    this.description,
    this.email,
    this.dob,
    this.phoneNumber,
    this.gender,
    this.schoolName,
    this.grade,
    this.stream,
    this.streamDetail,
    this.ambition,
    this.targetExam,
    this.languageModeTeaching,
    this.languageModeBooks,
    this.currentInstitute,
    this.coachingMode,
    this.country,
    this.state,
    this.city,
    this.area,
    this.pinCode,
  );

  static fromJson(Map<String, dynamic> json) {
    return Student(
      json["id"],
      json["avatar"] != null
          ? MediaObject.fromJson(json["avatar"].runtimeType == String
              ? jsonDecode(json["avatar"])
              : json["avatar"])
          : null,
      json["name"].toString().split(" ").first,
      json["name"].toString().split(" ").last,
      json["description"],
      json["email"],
      json["dob"],
      json["phonenumber"].toString(),
      json["gender"],
      json["schoolname"],
      json["grade"],
      json["stream"],
      json["streamdetail"],
      json["ambition"],
      json["targetexam"],
      json["languagemodeteaching"],
      json["languagemodebooks"],
      json["currentinstitute"],
      json["coachingmode"],
      json["location"] != null ? json["location"]["country"] : null,
      json["location"] != null ? json["location"]["state"] : null,
      json["location"] != null ? json["location"]["city"] : null,
      json["location"] != null ? json["location"]["area"] : null,
      json["location"] != null ? json["location"]["pincode"].toString() : null,
    );
  }

  String toJson() {
    Map<String, dynamic> data = {"usertype": 3};

    if (id != null) data.addAll({"id": id});
    if (avatar != null) data.addAll({"avatar": avatar!.toJson()});
    if (firstName != null && lastName != null) {
      data.addAll({"name": "$firstName $lastName"});
    }

    if (description != null) data.addAll({"description": description});
    if (email != null) data.addAll({"email": email});
    if (dob != null) data.addAll({"dob": dob});
    if (phoneNumber != null) {
      data.addAll({"phonenumber": int.parse(phoneNumber!)});
    }

    if (gender != null) data.addAll({"gender": gender});
    if (schoolName != null) {
      data.addAll({"schoolname": schoolName});
    }

    if (grade != null) data.addAll({"grade": grade});
    if (stream != null) data.addAll({"stream": stream});
    if (streamDetail != null) {
      data.addAll({"streamdetail": streamDetail});
    }

    if (ambition != null) data.addAll({"ambition": ambition});
    if (targetExam != null) {
      data.addAll({"targetexam": targetExam});
    }

    if (languageModeTeaching != null) {
      data.addAll({"languagemodeteaching": languageModeTeaching});
    }

    if (languageModeBooks != null) {
      data.addAll({"languagemodebooks": languageModeBooks});
    }

    if (currentInstitute != null) {
      data.addAll({"currentinstitute": currentInstitute});
    }

    if (coachingMode != null) {
      data.addAll({"coachingmode": coachingMode});
    }

    if (country != null &&
        state != null &&
        city != null &&
        area != null &&
        pinCode != null) {
      data.addAll({
        "location": {
          "country": country,
          "state": state,
          "city": city,
          "area": area,
          "pincode": pinCode,
        }
      });
    }

    return json.encode(data);
  }
}
