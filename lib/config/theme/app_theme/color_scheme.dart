part of 'app_theme.dart';

@immutable
class _ColorScheme {
  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _GeneratorColors.primary,
    onPrimary: _GeneratorColors.white,
    secondary: _GeneratorColors.grey,
    onSecondary: _GeneratorColors.lightGrey,
    tertiaryContainer: _GeneratorColors.white,
    onTertiaryContainer: _GeneratorColors.primary,
    error: _GeneratorColors.error,
    onError: _GeneratorColors.warning,
    background: _GeneratorColors.background,
    onBackground: _GeneratorColors.secondary,
    surface: _GeneratorColors.background,
    onSurface: _GeneratorColors.primary,
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _GeneratorColors.primary,
    onPrimary: _GeneratorColors.white,
    secondary: _GeneratorColors.grey,
    onSecondary: _GeneratorColors.lightGrey,
    tertiaryContainer: _GeneratorColors.white,
    onTertiaryContainer: _GeneratorColors.primary,
    error: _GeneratorColors.error,
    onError: _GeneratorColors.warning,
    background: _GeneratorColors.background,
    onBackground: _GeneratorColors.secondary,
    surface: _GeneratorColors.background,
    onSurface: _GeneratorColors.primary,
  );
/*
   static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _GeneratorColors.green,
    onPrimary: _GeneratorColors.lightGreen,
    secondary: _GeneratorColors.grey,
    onSecondary: _GeneratorColors.lightGrey,
    tertiaryContainer: _GeneratorColors.green,
    onTertiaryContainer: _GeneratorColors.green,
    error: _GeneratorColors.error,
    onError: _GeneratorColors.white,
    background: _GeneratorColors.background,
    onBackground: _GeneratorColors.lightGreen,
    surface: _GeneratorColors.white,
    onSurface: _GeneratorColors.white,
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _GeneratorColors.green,
    onPrimary: _GeneratorColors.white,
    secondary: _GeneratorColors.lightGreen,
    onSecondary: _GeneratorColors.white,
    tertiaryContainer: _GeneratorColors.green,
    onTertiaryContainer: _GeneratorColors.black,
    error: _GeneratorColors.error,
    onError: _GeneratorColors.white,
    background: _GeneratorColors.background,
    onBackground: _GeneratorColors.white,
    surface: _GeneratorColors.black,
    onSurface: _GeneratorColors.white,
  );
   */
}
