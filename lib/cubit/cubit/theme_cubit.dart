import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true);

  void changeTheme() {
    emit(!state);
  }

  @override
  List<Object> get props => [state];
}
