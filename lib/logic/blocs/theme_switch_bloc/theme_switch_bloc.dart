import 'package:CoinKeep/src/theme/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_switch_event.dart';
part 'theme_switch_state.dart';

class ThemeSwitchBloc extends HydratedBloc<ThemeEvent, ThemeSwitchState> {
  ThemeSwitchBloc() : super(InitialThemeState()) {
    on<ThemeEvent>((event, emit) {
      on<ToggleLightTheme>((event, emit) => emit(LightThemeState()));
      on<ToggleDarkTheme>((event, emit) => emit(DarkThemeState()));
    });
  }

  @override
  ThemeSwitchState? fromJson(Map<String, dynamic> json) {
    try {
      final themeType = json['theme'] as String;
      return themeType == 'light' ? LightThemeState() : DarkThemeState();
    } catch (_) {
      throw UnimplementedError();
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeSwitchState state) {
    try {
      return {
        'theme': state is LightThemeState ? 'light' : 'dark',
      };
    } catch (_) {
      throw UnimplementedError();
    }
  }
}
