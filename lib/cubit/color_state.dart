part of 'color_cubit.dart';

abstract class ColorState extends Equatable {
  final Color color;
  final bool themeMode;
  const ColorState(this.color, this.themeMode);

  @override
  List<Object> get props => [color, themeMode];
}

class ColorInitial extends ColorState {
  const ColorInitial(Color color, bool themeMode) : super(color, themeMode);
}

class ColorChange extends ColorState {
  final Color newColor;
  const ColorChange(this.newColor, bool themeMode) : super(newColor, themeMode);
}

class ColorLoading extends ColorState {
  const ColorLoading(Color color, bool themeMode) : super(color, themeMode);
}
