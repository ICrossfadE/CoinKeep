part of 'theme_switch_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleLightTheme extends ThemeEvent {}

class ToggleDarkTheme extends ThemeEvent {}
