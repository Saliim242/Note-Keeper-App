// To parse this JSON data, do
//
//     final noteStatisticsModel = noteStatisticsModelFromJson(jsonString);

import 'dart:convert';

NoteStatisticsModel noteStatisticsModelFromJson(String str) =>
    NoteStatisticsModel.fromJson(json.decode(str));

String noteStatisticsModelToJson(NoteStatisticsModel data) =>
    json.encode(data.toJson());

class NoteStatisticsModel {
  int? totalNotes;
  int? pinnedNotes;
  int? unpinnedNotes;
  List<NotesPerTag>? notesPerTag;
  List<NotesPerDay>? notesPerDay;

  NoteStatisticsModel({
    this.totalNotes,
    this.pinnedNotes,
    this.unpinnedNotes,
    this.notesPerTag,
    this.notesPerDay,
  });

  factory NoteStatisticsModel.fromJson(Map<String, dynamic> json) =>
      NoteStatisticsModel(
        totalNotes: json["totalNotes"],
        pinnedNotes: json["pinnedNotes"],
        unpinnedNotes: json["unpinnedNotes"],
        notesPerTag: json["notesPerTag"] == null
            ? []
            : List<NotesPerTag>.from(
                json["notesPerTag"]!.map((x) => NotesPerTag.fromJson(x)),
              ),
        notesPerDay: json["notesPerDay"] == null
            ? []
            : List<NotesPerDay>.from(
                json["notesPerDay"]!.map((x) => NotesPerDay.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "totalNotes": totalNotes,
    "pinnedNotes": pinnedNotes,
    "unpinnedNotes": unpinnedNotes,
    "notesPerTag": notesPerTag == null
        ? []
        : List<dynamic>.from(notesPerTag!.map((x) => x.toJson())),
    "notesPerDay": notesPerDay == null
        ? []
        : List<dynamic>.from(notesPerDay!.map((x) => x.toJson())),
  };
}

class NotesPerDay {
  DateTime? id;
  int? count;

  NotesPerDay({this.id, this.count});

  factory NotesPerDay.fromJson(Map<String, dynamic> json) => NotesPerDay(
    id: json["_id"] == null ? null : DateTime.parse(json["_id"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_id":
        "${id!.year.toString().padLeft(4, '0')}-${id!.month.toString().padLeft(2, '0')}-${id!.day.toString().padLeft(2, '0')}",
    "count": count,
  };
}

class NotesPerTag {
  int? count;
  String? tag;

  NotesPerTag({this.count, this.tag});

  factory NotesPerTag.fromJson(Map<String, dynamic> json) =>
      NotesPerTag(count: json["count"], tag: json["tag"]);

  Map<String, dynamic> toJson() => {"count": count, "tag": tag};
}
