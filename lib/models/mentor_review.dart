class MentorReview {
  String id;
  String mentorid;
  String studentid;
  String reviewtext;
  String studentname;

  List upvotedusers;

  int rating;
  int upvotes;

  DateTime publishedon;

  MentorReview({
    required this.id,
    required this.rating,
    required this.upvotes,
    required this.mentorid,
    required this.studentid,
    required this.reviewtext,
    required this.studentname,
    required this.publishedon,
    required this.upvotedusers,
  });

  static fromJson(Map<String, dynamic> json) {
    return MentorReview(
      id: json["id"],
      rating: json["rating"],
      upvotes: json["upvotes"],
      mentorid: json["mentorid"],
      studentid: json["studentid"],
      reviewtext: json["reviewtext"],
      studentname: json["studentname"],
      upvotedusers: json["upvotedusers"],
      publishedon: DateTime.parse(json["publishedon"]),
    );
  }

// String toJson() {
//   List imgs = [];
//   for (int i = 0; i < images.length; i++) {
//     imgs.add(images[i].toJson());
//   }
//
//   Map<String, dynamic> data = {
//     "id": id,
//     "reviewtext": reviewtext,
//     "user": user.toJson(),
//     "institute": institute.toJson(),
//     "images": imgs,
//   };
//
//   return json.encode(data);
// }
}
