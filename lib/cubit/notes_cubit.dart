import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/local/hive_service.dart';
import '../models/note_model.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final HiveService _hiveService;

  NotesCubit(this._hiveService) : super(NotesInitial());

  void loadNotes() {
    try {
      emit(NotesLoading());
      final notes = _hiveService.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      emit(NotesLoading());
      await _hiveService.addNote(note);
      final notes = _hiveService.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      emit(NotesLoading());
      await _hiveService.updateNote(note);
      final notes = _hiveService.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      emit(NotesLoading());
      await _hiveService.deleteNote(id);
      final notes = _hiveService.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  void searchNotes(String query) {
    try {
      if (query.isEmpty) {
        loadNotes();
        return;
      }
      final notes = _hiveService.searchNotes(query);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
