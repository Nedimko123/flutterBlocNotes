import 'package:bloccubit/cubit/notes_cubit.dart';
import 'package:bloccubit/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:jiffy/jiffy.dart';

class NoteEdit extends StatelessWidget {
  NoteEdit({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        _controller.text = state.list.first['name'];
        String selectedDate = state.list.first['date'];
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Editing: ${state.list.first}'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                ),
                Text('Editing: ${state.list.first['name']}'.toUpperCase()),
                Container(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (text) {
                      noteEditor(
                          index: state.list.first['id'],
                          name: text,
                          date: selectedDate);
                      context.read<NotesCubit>().loadNotes();
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.sanitizer),
                        border: OutlineInputBorder(),
                        hintText: '${state.list.first['name']}'),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) => selectedDate = val,
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                Wrap(
                  spacing: 35,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<NotesCubit>().loadNotes();
                        },
                        child: Text('BACK')),
                    ElevatedButton(
                        onPressed: () {
                          noteEditor(
                              index: state.list.first['id'],
                              name: _controller.text,
                              date: selectedDate);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Saved!')));
                          context.read<NotesCubit>().loadNotes();
                        },
                        child: Text('SAVE')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
