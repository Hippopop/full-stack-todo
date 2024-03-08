import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:todo_client/src/repository/source/response_error.dart';

typedef RawToDataPurse<T> = T Function(dynamic json);

T __purseErrorCatcher<T>(RawToDataPurse<T> pursingFunction, data) {
  try {
    return pursingFunction(data);
  } catch (e, s) {
    log("### PurseError ### \n Data : $data", error: e, stackTrace: s);
    rethrow;
  }
}

class ResponseWrapper<R> {
  int? status;
  String msg;
  Response rawResponse;
  List<RequestError>? error;

  ResponseWrapper({
    this.status,
    this.data,
    this.error,
    required this.msg,
    required this.rawResponse,
  });

  /* Actual data pursing : Start*/
  final R? data;
  dynamic get rawData => rawResponse.data;
  bool get isSuccess => data != null && error == null;
  bool get isError => !(isSuccess);

  factory ResponseWrapper.fromMap({
    bool print = false,
    required Response rawResponse,
    required RawToDataPurse<R> purserFunction,
  }) {
    if (print) log(rawResponse.data.toString());
    return switch (rawResponse.data) {
      {
        "status": int status,
        "msg": String msg,
        "error": List error,
      } =>
        ResponseWrapper<R>(
          status: status,
          msg: msg,
          rawResponse: rawResponse,
          error: List<RequestError>.from(
            error.map<RequestError?>(
              (x) => RequestError.fromMap(x as Map<String, dynamic>),
            ),
          ),
        ),
      {
        "status": int status,
        "msg": String msg,
        "data": dynamic data,
      } =>
        ResponseWrapper<R>(
          status: status,
          msg: msg,
          rawResponse: rawResponse,
          data: __purseErrorCatcher(purserFunction, data),
        ),
      _ => ResponseWrapper(
          rawResponse: rawResponse,
          status: rawResponse.statusCode,
          msg: "Response came back with a unknown data format!",
        ),
    };
  }
  /* Actual data pursing : End*/

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'msg': msg,
      'rawResponse': rawResponse,
      'error': error?.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'ResponseWrapper(\nstatus: $status,\n msg: $msg,\n rawData: ${rawResponse.data},\n error: $error,\n)';
  }
}
