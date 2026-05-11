import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_keeper/app/modules/home/model/notes_model.dart';
import 'package:note_keeper/app/modules/home/model/statistcs_model.dart';
import 'package:note_keeper/app/modules/user/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:note_keeper/app/utils/api_constants.dart';

class HomeProvider extends GetConnect {
  Future<List<NotesModel>> getNotes() async {
    var response = await http.get(
      Uri.parse("${kEndpoint}notes"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${box.read(kUserToken)}",
      },
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      List notes = decodedData['notes'];

      log("All Notes : ${notes}");

      return notes.map((notes) => NotesModel.fromJson(notes)).toList();
    } else {
      final decodedData = jsonDecode(response.body);

      throw decodedData['message'] ?? "Something went wrong";
    }
  }

  // Get All Note Statistcs

  Future<NoteStatisticsModel> getNoteStatistics() async {
    var response = await http.get(
      Uri.parse("${kEndpoint}notes/stats"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer ${box.read(kUserToken)}",
      },
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      var stats = decodedData['stats'];

      log("All Statistcs : ${stats}");

      return NoteStatisticsModel.fromJson(stats);
      // return stats.map((notes) => NoteStatisticsModel.fromJson(notes)).toList();
    } else {
      final decodedData = jsonDecode(response.body);

      throw decodedData['message'] ?? "Something went wrong";
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
