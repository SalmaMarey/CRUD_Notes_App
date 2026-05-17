import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_colors.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';
import '../widgets/note_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/delete_dialog.dart';
import 'add_edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                if (state is NotesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesLoaded) {
                  if (state.notes.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16).copyWith(top: 24),
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      final note = state.notes[index];
                      return NoteCard(
                        note: note,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditNoteScreen(note: note),
                            ),
                          );
                        },
                        onDelete: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => const DeleteDialog(),
                          );
                          if (confirm == true && context.mounted) {
                            context.read<NotesCubit>().deleteNote(note.id);
                          }
                        },
                      );
                    },
                  );
                } else if (state is NotesError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gradientStart,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: const Text(
            'My Notes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: -24,
          left: 24,
          right: 24,
          child: SearchBarWidget(
            onChanged: (query) {
              context.read<NotesCubit>().searchNotes(query);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notes, size: 64, color: AppColors.border),
          SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap the + button to create a note',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
