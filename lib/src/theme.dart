import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const kColorPrimary = Color(0xFF864D36);
const kColorPrimaryLight = Color(0xFFBF6E4C);
const kColorSecondary = Color(0xFF605226);
const kColorSecondaryLight = Color(0xFF867950);
const kColorBackgroundLight = Color(0xFFEDE7D8);
const kColorWhite = Colors.white;
const kColorError = Colors.redAccent;

class GlobalTheme {
  final globalTheme = ThemeData(
    colorScheme: _customColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: kColorSecondary,
        onPrimary: kColorWhite,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: kColorWhite,
      unselectedLabelColor: kColorSecondaryLight,
      indicator: BoxDecoration(color: kColorSecondaryLight),
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    textTheme: const TextTheme(
      headline1: _styleHeadline1,
      bodyText1: _styleBodyText1,
    ),
  );

  final markDownStyleSheet = MarkdownStyleSheet(
      p: _styleBodyText1,
      h1: _styleHeadline1,
      a: const TextStyle(
        color: kColorPrimary,
      ));
}

const _styleHeadline1 = TextStyle(fontSize: 24);
const _styleBodyText1 = TextStyle(height: 1.5);

const ColorScheme _customColorScheme = ColorScheme(
  primary: kColorPrimary,
  secondary: kColorSecondary,
  surface: kColorBackgroundLight,
  background: kColorWhite,
  error: kColorError,
  onPrimary: kColorPrimaryLight,
  onSecondary: kColorSecondaryLight,
  onSurface: kColorPrimary,
  onBackground: kColorPrimary,
  onError: kColorBackgroundLight,
  brightness: Brightness.light,
);
