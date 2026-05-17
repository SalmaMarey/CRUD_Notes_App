import 'package:hive_flutter/hive_flutter.dart';
import '../../models/note_model.dart';

class HiveService {
  static const String boxName = 'notes_box';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    await Hive.openBox<NoteModel>(boxName);
  }

  Box<NoteModel> get _box => Hive.box<NoteModel>(boxName);

  Future<void> addNote(NoteModel note) async {
    await _box.put(note.id, note);
  }

  Future<void> updateNote(NoteModel note) async {
    await _box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }

  List<NoteModel> getNotes() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date)); // descending by date
  }

  List<NoteModel> searchNotes(String query) {
    final lowerQuery = query.toLowerCase();
    return getNotes().where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
             note.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
