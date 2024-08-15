// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      state: $enumDecode(_$TodoStateEnumMap, json['state']),
      priority: $enumDecode(_$PriorityEnumMap, json['priority']),
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'state': _$TodoStateEnumMap[instance.state]!,
      'priority': _$PriorityEnumMap[instance.priority]!,
    };

const _$TodoStateEnumMap = {
  TodoState.active: 'active',
  TodoState.completed: 'completed',
};

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
};
