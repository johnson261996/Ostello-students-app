class School {
  String id;
  String schoolName;
  String address;
  String? district;
  String? shift;
  String? schoolLevel;
  String? gender;
  String? phone;
  String? latitude;
  String? longitude;

  School({
    required this.id,
    required this.district,
    required this.schoolName,
    required this.address,
    required this.shift,
    required this.schoolLevel,
    required this.gender,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  static fromJson(Map<String, dynamic> json) {
    return School(
      id: json["_id"],
      schoolName: json["School Name"],
      address: json["Address"],
      district: json["District"],
      shift: json["Shift"],
      gender: json["Gender"],
      phone: json["Phone"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      schoolLevel: json["SchoolLevel"],
    );
  }
}
