import 'package:bloccubit/cubit/cubit/theme_cubit.dart';
import 'package:bloccubit/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'noteList.dart';

class NotesMain extends StatelessWidget {
  const NotesMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: Colors.grey, useMaterial3: true),
          darkTheme: ThemeData(
              colorSchemeSeed: Colors.indigo,
              useMaterial3: true,
              brightness: Brightness.dark),
          themeMode: context.read<ThemeCubit>().state
              ? ThemeMode.light
              : ThemeMode.dark,
          home: BlocProvider(
            create: (_) => NotesCubit(),
            child: const NoteList(),
          ),
        );
      },
    );
  }
}
