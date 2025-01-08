part of 'theme_switch_bloc.dart';

class ThemeSwitchState extends Equatable {
  final ThemeData themeData;
  const ThemeSwitchState(this.themeData);

  @override
  List<Object> get props => [];
}

class InitialThemeState extends ThemeSwitchState {
  InitialThemeState() : super(darkMode);
}

class LightThemeState extends ThemeSwitchState {
  LightThemeState() : super(lightMode);
}

class DarkThemeState extends ThemeSwitchState {
  DarkThemeState() : super(darkMode);
}
