import 'dart:convert';

class MediaObject {
  String key;
  String url;

  MediaObject({
    required this.key,
    required this.url,
  });

  static fromJson(Map<String, dynamic> json) {
    return MediaObject(
      key: json["key"],
      url: json["url"],
    );
  }

  String toJson() {
    Map<String, dynamic> data = {};

    data.addAll({"key": key});
    data.addAll({"url": url});

    return json.encode(data);
  }
}
