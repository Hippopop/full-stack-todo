import 'dart:developer';

sealed class RequestError<T> {
  final List<T> codes;
  final String description;

  const RequestError({
    required this.codes,
    required this.description,
  });

  Map<String, dynamic> toMap();

  static RequestError fromMap(data) {
    try {
      final pursedMap = Map<String, dynamic>.from(data);
      return _serializedErrorFromMap(pursedMap);
    } catch (e, s) {
      log("#Pursing Error on (RequestError):", error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Actual purser! Not safe to use directly!
  static RequestError _serializedErrorFromMap(Map<String, dynamic> errorMap) {
    if (errorMap.containsKey('codes') && errorMap.containsKey('description')) {
      final code = errorMap['codes'];
      if (code is String ||
          (code is List && code.every((element) => element is String))) {
        return RequestErrorWithKeys.fromMap(errorMap);
      }
      if (code is int ||
          (code is List && code.every((element) => element is int))) {
        return RequestErrorWithCode.fromMap(errorMap);
      }
    }
    return const RequestErrorUnknown(
      codes: [500],
      description: "Unknown server error!",
    );
  }
}

///Request came back with an error. Which is not any of the expected types.
///[String || List<String> || int || List<int>].
class RequestErrorUnknown<T> extends RequestError<T> {
  const RequestErrorUnknown({
    required super.codes,
    required super.description,
  });

  static RequestError fromMap(Map<String, dynamic> data) {
    return RequestErrorUnknown(
      codes: data['codes'],
      description: data['description'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {"codes": codes, "description": description};
}

///Request came back with error. And has codes of type [String || List<String>].
class RequestErrorWithKeys extends RequestError<String> {
  const RequestErrorWithKeys({
    required super.codes,
    required super.description,
  });

  static RequestError fromMap(Map<String, dynamic> data) {
    final code = data['codes'];
    final desc = data['description'];
    if (code is String) {
      return RequestErrorWithKeys(codes: [code], description: desc);
    } else {
      return RequestErrorWithCode(
        codes: (code as List).cast(),
        description: desc,
      );
    }
  }

  @override
  Map<String, dynamic> toMap() => {"codes": codes, "description": description};
}

///Request came back with error. And has codes of type [int || List<int>]
class RequestErrorWithCode extends RequestError<int> {
  const RequestErrorWithCode({
    required super.codes,
    required super.description,
  });

  static RequestError fromMap(Map<String, dynamic> data) {
    final code = data['codes'];
    final desc = data['description'];
    if (code is int) {
      return RequestErrorWithCode(codes: [code], description: desc);
    } else {
      return RequestErrorWithCode(
        codes: (code as List).cast(),
        description: desc,
      );
    }
  }

  @override
  Map<String, dynamic> toMap() => {"codes": codes, "description": description};
}
