import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//! THEME EXTENSION
extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  IconThemeData get iconTheme => Theme.of(this).iconTheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;
  InputDecorationTheme get inputDecoration =>
      Theme.of(this).inputDecorationTheme;
}

//! SCREEN EXTENSION
extension MediaQueryExtensions on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}

//! BLOC EXTENSION
extension CubitExtension<T extends Cubit<Object>> on BuildContext {
  // ignore: avoid_shadowing_type_parameters
  T bloc<T extends Cubit<Object>>() {
    try {
      return BlocProvider.of<T>(this);
    } catch (_) {
      throw Exception('Cannot find bloc of type $T.');
    }
  }
}

//! NAVIGATOR EXTENSION
extension NavigatorExtensions on BuildContext {
  void push(Widget screen) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => screen));
  void pushReplacement(Widget screen) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  void pop() => Navigator.of(this).pop();
}
