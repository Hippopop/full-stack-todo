import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get capFirst {
    final char = characters.first;
    return replaceRange(0, 1, char.toUpperCase());
  }
}
