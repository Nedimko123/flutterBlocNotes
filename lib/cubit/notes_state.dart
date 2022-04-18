part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  final List list;
  const NotesState(this.list);

  @override
  List<Object> get props => [list];
}

class NotesInitial extends NotesState {
  final List _list;
  const NotesInitial(this._list) : super(_list);
}

class NotesLoading extends NotesState {
  final List _list;
  const NotesLoading(this._list) : super(_list);
}

class NotesLoaded extends NotesState {
  final List list123;

  const NotesLoaded(this.list123) : super(list123);

  @override
  List<Object> get props => [list123];
}

class NotesEdit extends NotesState {
  final List list12;

  const NotesEdit(this.list12) : super(list12);

  @override
  List<Object> get props => [list12];
}

class NotesAdd extends NotesState {
  final List _list;
  const NotesAdd(this._list) : super(_list);
}

class NotesDoneState extends NotesState {
  final List _list;
  const NotesDoneState(this._list) : super(_list);
}
