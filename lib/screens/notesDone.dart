import 'package:bloccubit/cubit/cubit/theme_cubit.dart';
import 'package:bloccubit/cubit/notes_cubit.dart';
import 'package:bloccubit/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesDone extends StatelessWidget {
  const NotesDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Done notes')),
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
                  title: const Text('Notes'),
                  onTap: () {
                    context.read<NotesCubit>().loadNotes();

                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                      tileColor: Colors.green.shade200,
                      textColor: Colors.black,
                      onTap: () {
                        context
                            .read<NotesCubit>()
                            .editNotes(id: state.list[index]['id']);
                      },
                      title: Text(state.list[index]['name']),
                      subtitle: Text(
                          "Date set: ${state.list[index]['date']}, Date done: ${state.list[index]['dateDone']}"),
                      trailing: IconButton(
                        onPressed: () {
                          noteDoneDelete(index: state.list[index]['id']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade300,
                        ),
                        // trailing: IconButton(
                        //     onPressed: () {
                        //       noteDelete(index: state.list[index]['id']);
                        //       context.read<NotesCubit>().loadNotes();
                        //     },
                        //     icon: Icon(Icons.delete_forever)),
                      ));
                })),
          ),
        );
      },
    );
  }
}
