import 'package:bloc/bloc.dart';
import 'package:bloccubit/screens/noteList.dart';
import 'package:equatable/equatable.dart';
import '../database/db.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial([]));

  Future<void> loadNotes() async {
    var notes = await selector();
    emit(NotesLoaded(notes));
  }

  Future<void> loadNotesDone() async {
    var notes = await selectorDone();
    emit(NotesDoneState(notes));
  }

  Future<void> loadNotesDate() async {
    var notes = await selectorbyDate();
    emit(NotesLoaded(notes));
  }

  Future<void> editNotes({required int id}) async {
    var notes = await selectorbyId(index: id);
    emit(NotesEdit(notes));
  }
}
