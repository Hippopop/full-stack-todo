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
      const defaultError =
          RequestErrorUnknown(codes: [], description: "Unknown Error!");
      return switch (data) {
        {"codes": List _, "description": String desc} => switch (data) {
            {"codes": List<int> codes, "description": _} =>
              RequestErrorWithCode(codes: codes, description: desc),
            {"codes": List<String> codes, "description": _} =>
              RequestErrorWithKeys(codes: codes, description: desc),
            _ => defaultError,
          },
        {
          "codes": String code,
          "description": String desc,
        } =>
          RequestErrorWithKeys(codes: [code], description: desc),
        {
          "codes": int code,
          "description": String desc,
        } =>
          RequestErrorWithCode(codes: [code], description: desc),
        _ => defaultError,
      } as RequestError;
    } catch (e, s) {
      log("#Pursing Error on (RequestError):", error: e, stackTrace: s);
      rethrow;
    }
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
