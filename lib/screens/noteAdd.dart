import 'package:bloccubit/cubit/notes_cubit.dart';
import 'package:bloccubit/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:jiffy/jiffy.dart';

class NoteAdd extends StatelessWidget {
  NoteAdd({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  String selectedDate = Jiffy().format("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Add a new note')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Add new note'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (text) {
                    noteInsertor(name: _controller.text, date: selectedDate);
                    context.read<NotesCubit>().loadNotes();
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.sanitizer),
                      border: OutlineInputBorder(),
                      hintText: 'Input note name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
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
                spacing: 20,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<NotesCubit>().loadNotes();
                      },
                      child: Text('BACK')),
                  ElevatedButton(
                      onPressed: () async {
                        noteInsertor(
                            name: _controller.text, date: selectedDate);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Added note: ${_controller.text}')));
                        context.read<NotesCubit>().loadNotes();
                      },
                      child: Text('SUBMIT')),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
