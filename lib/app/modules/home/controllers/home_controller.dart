import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:note_keeper/app/modules/home/model/notes_model.dart';
import 'package:note_keeper/app/modules/home/model/statistcs_model.dart';

import '../../../utils/events/user_events.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController {
  GetAllNotes allNotes = GetAllNotes.intial;
  GetNoteStatistics noteStatistics = GetNoteStatistics.intial;
  CreateNewNote createNote = CreateNewNote.intial;
  UpdateNote noteUpdate = UpdateNote.intial;

  List<NotesModel> notes = [];
  NoteStatisticsModel statistcs = NoteStatisticsModel();
  NotesModel newNote = NotesModel();

  Future<void> getAllNotes({
    required Function(List<NotesModel> notes) onSuccess,
    required Function(String err) onError,
  }) async {
    try {
      allNotes = GetAllNotes.loading;
      update();

      final response = await HomeProvider().getNotes();
      notes = response;
      allNotes = GetAllNotes.success;
      update();
      onSuccess(notes);
    } on TimeoutException {
      allNotes = GetAllNotes.networkError;

      update();
      onError("Please Check Your Internt Connection.");
    } on SocketException {
      allNotes = GetAllNotes.networkError;

      update();
      onError("Please Check Your Internt Connection.");
    } catch (e) {
      allNotes = GetAllNotes.error;
      update();
      onError(e.toString());
    }
  }

  // Get Note Statistcs

  Future<void> getNoteStatistics({
    required Function(NoteStatisticsModel stats) onSuccess,
    required Function(String err) onError,
  }) async {
    try {
      noteStatistics = GetNoteStatistics.loading;
      update();

      final response = await HomeProvider().getNoteStatistics();
      statistcs = response;
      noteStatistics = GetNoteStatistics.success;
      update();
      onSuccess(statistcs);
    } on TimeoutException {
      noteStatistics = GetNoteStatistics.networkError;

      update();
      onError("Please Check Your Internt Connection.");
    } on SocketException {
      noteStatistics = GetNoteStatistics.networkError;

      update();
      onError("Please Check Your Internt Connection.");
    } catch (e) {
      noteStatistics = GetNoteStatistics.error;
      update();
      onError(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
