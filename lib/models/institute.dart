import "./location.dart";
import './media_object.dart';

class Institute {
  String id;
  String name;
  String description;
  String? shortDescription;
  List<String> coursecategories;

  int rating;
  int establishedyear;
  int? studentsenrolled;

  List<Location> locations;
  List<MediaObject> images;
  List<MediaObject> videos;

  Institute({
    required this.id,
    required this.name,
    required this.rating,
    required this.images,
    required this.videos,
    required this.locations,
    required this.description,
    required this.establishedyear,
    required this.shortDescription,
    required this.coursecategories,
    this.studentsenrolled,
  });

  static parseLocations(List locs) {
    List<Location> parsedLocations = [];
    parsedLocations.add(Location.fromJson(locs[0]));
    return parsedLocations;
  }

  static parseCategories(List cats) {
    List<String> parsedCategories = [];

    for (int i = 0; i < parsedCategories.length; i++) {
      parsedCategories.add(cats[i].toString());
    }

    return parsedCategories;
  }

  static parseImages(List imgs) {
    List<MediaObject> parsedImages = [];

    for (int i = 0; i < imgs.length; i++) {
      parsedImages.add(MediaObject.fromJson(imgs[i]));
    }

    return parsedImages;
  }

  static parseVideos(List vids) {
    List<MediaObject> parsedVideos = [];

    for (int i = 0; i < vids.length; i++) {
      parsedVideos.add(MediaObject.fromJson(vids[i]["video"]));
    }

    return parsedVideos;
  }

  static fromJson(Map<String, dynamic> json) {
    return Institute(
      id: json["id"],
      name: json["name"],
      rating: json["rating"],
      description: json["description"],
      images: parseImages(json["images"]),
      videos: parseVideos(json["videos"]),
      establishedyear: json["establishedyear"],
      studentsenrolled: json["studentsenrolled"],
      shortDescription: json["short_description"],
      locations: parseLocations(json["locations"]),
      coursecategories: parseCategories(json["coursecategories"]),
    );
  }

// String toJson() {
//   List locs = [];
//   for (int i = 0; i < locations.length; i++) {
//     locs.add(locations[i].toJson());
//   }
//
//   List imgs = [];
//   for (int i = 0; i < images.length; i++) {
//     imgs.add(images[i].toJson());
//   }
//
//   Map<String, dynamic> data = {
//     "id": id,
//     "name": name,
//     "images": imgs,
//     "rating": rating,
//     "locations": locs,
//     "description": description,
//     "establishedyear": establishedyear,
//     "studentsenrolled": studentsenrolled,
//     "coursecategories": coursecategories,
//     "short_description": shortDescription,
//   };
//
//   return json.encode(data);
// }
}
