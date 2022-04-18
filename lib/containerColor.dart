import 'package:bloccubit/cubit/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool colors = true;

class ContainerColor extends StatelessWidget {
  const ContainerColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        if (state is ColorLoading) {
          return MaterialApp(
            darkTheme: ThemeData(colorSchemeSeed: Colors.red),
            themeMode: colors ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.blueGrey,
                  title: GestureDetector(
                    child: Text('Loading...'),
                    onTap: () {
                      colors = !colors;
                      print(colors);
                    },
                  ),
                )),
          );
        }
        return MaterialApp(
          theme: ThemeData(colorSchemeSeed: Colors.lightBlue),
          darkTheme: ThemeData(colorSchemeSeed: Colors.red),
          themeMode: colors ? ThemeMode.light : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: GestureDetector(
                child: Text('Loaded'),
                onTap: () {
                  colors = !colors;
                  print(colors);

                  context
                      .read<ColorCubit>()
                      .emit(ColorChange(Colors.indigo, colors));
                },
              ),
            ),
            body: GestureDetector(
              child: Container(
                child: Text(
                  'Hello  ',
                  style: TextStyle(fontSize: 50),
                ),
                width: double.infinity,
              ),
              onTap: () {
                context.read<ColorCubit>().changeColor(themeMode: colors);
              },
            ),
          ),
        );
      },
    );
  }
}
