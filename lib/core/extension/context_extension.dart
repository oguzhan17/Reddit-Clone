import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  ThemeData get theme => Theme.of(this);
}

extension NumberExtension on BuildContext {
  double get lowValueH => dynamicHeight(0.01);
  double get mediumValueH => dynamicHeight(0.02);
  double get highValueH => dynamicHeight(0.03);

  double get lowValueW => dynamicWidth(0.01);
  double get mediumValueW => dynamicWidth(0.02);
  double get highValueW => dynamicWidth(0.03);

}