import 'dart:convert';

import './student.dart';

class Wallet {
  String id;
  int balance;
  List<String> offers;
  String referralcode;
  Student student;
  List<Student> referrals;

  Wallet({
    required this.id,
    required this.offers,
    required this.student,
    required this.balance,
    required this.referrals,
    required this.referralcode,
  });

  static fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json["id"],
      balance: json["balance"],
      referralcode: json["referralcode"],
      offers: parseOffers(json["offers"]),
      student: Student.fromJson(json["student"]),
      referrals: parseStudents(json["referrals"]),
    );
  }

  static List<String> parseOffers(List offers) {
    List<String> tempOffers = [];

    for (int i = 0; i < offers.length; i++) {
      tempOffers.add(offers[i].toString());
    }

    return tempOffers;
  }

  static List<Student> parseStudents(List students) {
    List<Student> tempStudents = [];

    for (int i = 0; i < students.length; i++) {
      tempStudents.add(Student.fromJson(students[i]));
    }

    return tempStudents;
  }

  List<String> encodeStudents(List<Student> students) {
    List<String> tempStudents = [];

    for (int i = 0; i < students.length; i++) {
      tempStudents.add(students[i].toJson());
    }

    return tempStudents;
  }

  String toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "offers": offers,
      "balance": balance,
      "student": student.toJson(),
      "referralcode": referralcode,
      "referrals": encodeStudents(referrals),
    };

    return json.encode(data);
  }
}
