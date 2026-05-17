import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date];
}
