import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorInitial(Colors.indigo, false));

  void changeColor({required bool themeMode}) async {
    emit(ColorLoading(Colors.indigo, themeMode));
    await Future.delayed(Duration(seconds: 1));
    RandomColor _randomColor = RandomColor();
    Color _color = _randomColor.randomColor();
    emit(ColorChange(_color, themeMode));
  }
}
