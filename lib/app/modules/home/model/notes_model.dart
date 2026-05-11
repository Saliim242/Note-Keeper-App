// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

NotesModel notesModelFromJson(String str) =>
    NotesModel.fromJson(json.decode(str));

String notesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  String? id;
  String? userId;
  String? title;
  String? content;
  List<String>? tags;
  bool? isPinned;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotesModel({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.tags,
    this.isPinned,
    this.createdAt,
    this.updatedAt,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    content: json["content"],
    tags: json["tags"] == null
        ? []
        : List<String>.from(json["tags"]!.map((x) => x)),
    isPinned: json["isPinned"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "content": content,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "isPinned": isPinned,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
