import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

enum Priority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
}

enum TodoState {
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
}

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    String? description,
    required TodoState state,
    required Priority priority,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json) => _$TodoFromJson(json);
}
