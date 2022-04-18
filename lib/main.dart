import 'package:bloccubit/cubit/cubit/theme_cubit.dart';

import 'package:bloccubit/screens/notesMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createdatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: NotesMain(),
    );
  }
}
