import 'package:flutter/material.dart';

const defaultFieldName = "Field";
typedef Validation = (bool?, String) Function(String value, String name);
typedef ValidationHelper = FormFieldValidator<String> Function(
  List<Validation>, {
  String? name,
  FocusNode? focusNode,
});

/// Helpers!
final _emailRegex = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
Validation isEmail =
    (value, name) => (!_emailRegex.hasMatch(value), "Enter a valid email.");
Validation isRequired = (value, name) => (value.isEmpty, "$name is required!");
Validation tooShort8 = (value, name) =>
    (value.length < 8, "$name is too short! Minimum 8 characters.");
Validation tooShort6 = (value, name) =>
    (value.length < 6, "$name is too short! Minimum 6 characters.");

class FieldValidator {
  /// A function that returns the actual validator and and adds the mundane things we need to do everyday!
  static FormFieldValidator<String> validate(List<Validation>? validators,
      {String? name, FocusNode? focusNode}) {
    return (String? value) {
      assert(value != null, "Fields value can't be null!");
      String? result;
      for (Validation checkers in validators ?? []) {
        final (state, response) = checkers(
          value!,
          name ?? defaultFieldName,
        );
        if (state ?? false) {
          result = response;
          focusNode?.requestFocus();
          break;
        }
      }
      return result;
    };
  }
}
