import 'dart:convert';

class Location {
  String line1;
  String line2;
  int pincode;
  String area;
  String city;
  String state;
  String country;

  Location({
    required this.line1,
    required this.line2,
    required this.pincode,
    required this.area,
    required this.city,
    required this.state,
    required this.country,
  });

  static fromJson(Map<String, dynamic> json) {
    return Location(
      line1: json["line1"],
      line2: json["line2"] ?? "",
      area: json["area"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      pincode: int.parse(json["pincode"].toString()),
    );
  }

  String toJson() {
    Map<String, dynamic> data = {
      "area": area,
      "city": city,
      "line1": line1,
      "line2": line2,
      "state": state,
      "country": country,
      "pincode": pincode,
    };

    return json.encode(data);
  }
}
