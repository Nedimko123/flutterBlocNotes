import 'package:bloccubit/cubit/cubit/theme_cubit.dart';
import 'package:bloccubit/cubit/notes_cubit.dart';
import 'package:bloccubit/database/db.dart';
import 'package:bloccubit/screens/noteAdd.dart';
import 'package:bloccubit/screens/noteEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_share/flutter_share.dart';
import 'notesDone.dart';
import 'package:jiffy/jiffy.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String datenow = Jiffy().format("yyyy-MM-dd HH:mm");
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesInitial) {
          context.read<NotesCubit>().loadNotes();
        }
        if (state is NotesLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
            appBar: AppBar(
              title: Text('Loading'),
            ),
          );
        }
        if (state is NotesEdit) {
          return NoteEdit();
        }
        if (state is NotesDoneState) {
          return NotesDone();
        }
        if (state is NotesAdd) {
          return NoteAdd();
        }
        return Scaffold(
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Text(
                    'Options',
                    style: TextStyle(fontSize: 54),
                  ),
                ),
                ListTile(
                  title: const Text('Done notes'),
                  onTap: () {
                    context.read<NotesCubit>().loadNotesDone();
                    Navigator.of(context).pop();
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Sort by date'),
                  onTap: () {
                    context.read<NotesCubit>().loadNotesDate();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Sort by name'),
                  onTap: () {
                    context.read<NotesCubit>().loadNotes();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                context.read<NotesCubit>().emit(NotesAdd([]));
              }),
          appBar: AppBar(
            actions: [
              Switch(
                  value: context.read<ThemeCubit>().state,
                  onChanged: (value) {
                    context.read<ThemeCubit>().changeTheme();
                    context.read<NotesCubit>().emit(NotesInitial([]));
                  })
            ],
            title: GestureDetector(
              child: Text('Notes'),
              onTap: () {},
            ),
          ),
          body: Center(
            child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: ((context, index) {
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.

                          onPressed: (BuildContext context) {
                            noteDoneInsertor(
                                name: state.list[index]['name'],
                                date: state.list[index]['date'],
                                dateDone: datenow);
                            noteDelete(index: state.list[index]['id']);
                            context.read<NotesCubit>().loadNotes();
                          },
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.done,
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                            await FlutterShare.share(
                                title: 'Sharing',
                                text:
                                    'Note: ${state.list[index]['name']}, Date: ${state.list[index]['date']}');
                          },
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            noteDelete(index: state.list[index]['id']);
                            context.read<NotesCubit>().loadNotes();
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        context
                            .read<NotesCubit>()
                            .editNotes(id: state.list[index]['id']);
                      },
                      title: Text(state.list[index]['name']),
                      subtitle: Text("Date: ${state.list[index]['date']}"),
                      // trailing: IconButton(
                      //     onPressed: () {
                      //       noteDelete(index: state.list[index]['id']);
                      //       context.read<NotesCubit>().loadNotes();
                      //     },
                      //     icon: Icon(Icons.delete_forever)),
                    ),
                  );
                })),
          ),
        );
      },
    );
  }
}
