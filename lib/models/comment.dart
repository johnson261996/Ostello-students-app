import 'dart:convert';

import './post.dart';
import './student.dart';

class Comment {
  String? id;
  String? text;

  bool? liked;
  int? boosts;
  int? views;

  Post? post;
  Student commentor;
  List<Comment> replies;

  final String? createdAt;
  final String? updatedAt;

  Comment(
    this.id,
    this.text,
    this.liked,
    this.boosts,
    this.views,
    this.post,
    this.commentor,
    this.replies,
    this.createdAt,
    this.updatedAt,
  );

  static parseReplies(List jsonReplies) {
    List<Comment> replies = [];

    for (int i = 0; i < jsonReplies.length; i++) {
      replies.add(fromJson(jsonReplies[i]));
    }

    return replies;
  }

  static fromJson(Map<String, dynamic> json) {
    return Comment(
      json["id"],
      json["text"],
      json["liked"],
      int.tryParse(json["boosts"]),
      int.tryParse(json["views"]),
      Post.fromJson(json["post"]),
      Student.fromJson(json["commentor"]),
      parseReplies(json["replies"]),
      json["created_at"],
      json["updated_at"],
    );
  }

  List<String> encodeReplies() {
    List<String> tempReplies = [];

    for (int i = 0; i < replies.length; i++) {
      tempReplies.add(replies[i].toJson());
    }

    return tempReplies;
  }

  String toJson() {
    Map<String, dynamic> data = {};

    if (id != null) data.addAll({"id": id});
    if (text != null) data.addAll({"title": text});

    if (liked != null) data.addAll({"liked": liked});
    if (views != null) data.addAll({"views": views});
    if (boosts != null) data.addAll({"boosts": boosts});

    data.addAll({"post": post?.toJson()});
    data.addAll({"commentor": commentor.toJson()});
    data.addAll({"replies": encodeReplies()});

    if (createdAt != null) data.addAll({"created_at": createdAt});
    if (updatedAt != null) data.addAll({"updated_at": updatedAt});

    return json.encode(data);
  }
}
