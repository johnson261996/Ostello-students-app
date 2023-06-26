import './institute.dart';
import './media_object.dart';
import './student.dart';

class Review {
  String id;
  int rating;
  int upvotes;
  String reviewtext;
  List<MediaObject> images;
  List<MediaObject> videos;

  Student user;
  Institute institute;
  DateTime publishedon;

  Review({
    required this.id,
    required this.user,
    required this.rating,
    required this.images,
    required this.videos,
    required this.upvotes,
    required this.institute,
    required this.reviewtext,
    required this.publishedon,
  });

  static parseMedia(List media) {
    List<MediaObject> parsedMedia = [];

    for (int i = 0; i < media.length; i++) {
      parsedMedia.add(MediaObject.fromJson(media[i]));
    }

    return parsedMedia;
  }

  // static parseImages(List imgs) {
  //   List<MediaObject> parsedImages = [];
  //
  //   for (int i = 0; i < imgs.length; i++) {
  //     parsedImages.add(MediaObject.fromJson(imgs[i]));
  //   }
  //
  //   return parsedImages;
  // }
  //
  // static parseVideos(List vids) {
  //   List<MediaObject> parsedVideos = [];
  //
  //   for (int i = 0; i < vids.length; i++) {
  //     parsedVideos.add(MediaObject.fromJson(vids[i]));
  //   }
  //
  //   return parsedVideos;
  // }

  static fromJson(Map<String, dynamic> json) {
    return Review(
        id: json["id"],
        rating: json["rating"],
        upvotes: json["upvotes"],
        reviewtext: json["reviewtext"],
        images: parseMedia(json["images"]),
        videos: json["videos"] != null ? parseMedia(json["videos"]) : [],
        user: Student.fromJson(json["user"]),
        institute: Institute.fromJson(json["institute"]),
        publishedon: DateTime.parse(json["publishedon"]));
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
