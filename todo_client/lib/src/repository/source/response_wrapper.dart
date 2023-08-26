import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:todo_client/src/repository/source/response_error.dart';

typedef RawToDataPurse<Z, T> = FutureOr<Z> Function(T? rawData);

class ResponseWrapper<T, C> {
  int status;
  String msg;
  T? rawResponse;
  List<RequestError>? error;

  ResponseWrapper({
    required this.status,
    required this.msg,
    this.rawResponse,
    this.error,
  });

  /* Actual data pursing : Start*/

  late final C? data;
  bool get isError => error != null && data == null;
  bool get isSuccess => data != null && error == null;

  FutureOr<void> purseResponse<Z extends C>(
    RawToDataPurse<Z, T> purserFunction,
  ) async {
    try {
      data = await purserFunction(rawResponse);
    } catch (e, s) {
      log(
        "Tried to purse **${rawResponse.runtimeType} (to) ${Z.runtimeType}! \n RawResponse => ${rawResponse.toString()}",
        error: e,
        stackTrace: s,
        name: "#RES_PURSE_ERROR",
      );
      rethrow;
    }
  }

  factory ResponseWrapper.fromMap(dynamic rawData, [bool print = false]) {
    if (print) {
      log(rawData.toString());
    }
    final map = Map<String, dynamic>.from(rawData as Map);
    return ResponseWrapper<T, C>(
      status: map['status'] as int,
      msg: map['msg'] as String,
      rawResponse: map['data'] != null ? map['data'] as T : null,
      error: map['error'] != null
          ? List<RequestError>.from(
              (map['error'] as List).map<RequestError?>(
                (x) => RequestError.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  /* Actual data pursing : End*/

  ResponseWrapper<T, C> copyWith({
    int? status,
    String? msg,
    T? rawResponse,
    List<RequestError>? error,
  }) {
    return ResponseWrapper<T, C>(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      rawResponse: rawResponse ?? this.rawResponse,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'rawResponse': rawResponse,
      'error': error?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ResponseWrapper.fromJson(String source) =>
      ResponseWrapper.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseWrapper(status: $status, msg: $msg, rawResponse: $rawResponse, error: $error)';
  }

  @override
  bool operator ==(covariant ResponseWrapper<T, C> other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.msg == msg &&
        other.rawResponse == rawResponse &&
        listEquals(other.error, error);
  }

  @override
  int get hashCode {
    return status.hashCode ^
        msg.hashCode ^
        rawResponse.hashCode ^
        error.hashCode;
  }
}
