import 'dart:convert';

import "./comment.dart";
import './student.dart';

class Post {
  String id;
  String title;
  String description;
  List<String> tags;

  bool liked;
  bool blocked;
  int boosts;
  int views;

  Student author;
  List<Comment> comments;

  String createdAt;
  String updatedAt;

  Post(
    this.id,
    this.title,
    this.description,
    this.tags,
    this.liked,
    this.blocked,
    this.boosts,
    this.views,
    this.author,
    this.comments,
    this.createdAt,
    this.updatedAt,
  );

  static parseTags(List<dynamic> dynamicTags) {
    List<String> stringTags = [];

    for (int i = 0; i < dynamicTags.length; i++) {
      stringTags.add(dynamicTags[i].toString());
    }

    return stringTags;
  }

  static parseComments(List jsonComments) {
    List<Comment> tempComments = [];

    for (int i = 0; i < jsonComments.length; i++) {
      tempComments.add(Comment.fromJson(jsonComments[i]));
    }

    return tempComments;
  }

  static fromJson(Map<String, dynamic> json) {
    return Post(
      json["id"],
      json["title"],
      json["description"],
      parseTags(json["tags"]),
      json["liked"],
      json["blocked"] ?? false,
      int.parse(json["boosts"]),
      int.parse(json["views"]),
      Student.fromJson(json["author"]),
      parseComments(json["comments"]),
      json["created_at"],
      json["updated_at"],
    );
  }

  List<String> encodeComments() {
    List<String> tempComments = [];

    for (int i = 0; i < comments.length; i++) {
      tempComments.add(comments[i].toJson());
    }

    return tempComments;
  }

  String toJson() {
    Map<String, dynamic> data = {
      "id": id,
      "title": title,
      "description": description,
      "tags": tags,
      "liked": liked,
      "blocked": blocked,
      "boosts": boosts,
      "views": views,
      "author": author.toJson(),
      "comments": encodeComments(),
      "created_at": createdAt,
      "updated_at": updatedAt,
    };

    return json.encode(data);
  }
}
