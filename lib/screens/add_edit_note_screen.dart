import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../core/theme/app_colors.dart';
import '../cubit/notes_cubit.dart';
import '../models/note_model.dart';
import '../widgets/custom_text_field.dart';

class AddEditNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _descController = TextEditingController(text: widget.note?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    if (isEditing) {
      final updatedNote = widget.note!.copyWith(
        title: title,
        description: description,
        date: DateTime.now(),
      );
      context.read<NotesCubit>().updateNote(updatedNote);
    } else {
      final newNote = NoteModel(
        id: const Uuid().v4(),
        title: title,
        description: description,
        date: DateTime.now(),
      );
      context.read<NotesCubit>().addNote(newNote);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Title',
                    hint: 'Enter note title',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 300,
                    child: CustomTextField(
                      label: 'Description',
                      hint: 'Write your note here...',
                      controller: _descController,
                      expand: true,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saveNote,
                      icon: const Icon(Icons.check),
                      label: const Text('Save Note'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Text(
              isEditing ? 'Edit Note' : 'New Note',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48), // To balance the back button
        ],
      ),
    );
  }
}
