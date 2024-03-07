import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/source/response_wrapper.dart';
import 'package:todo_client/src/utilities/dribble_snackbar/scaffold_utilities.dart';

final requestHandlerProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});

final _fresh = Fresh.oAuth2(
  tokenStorage: InMemoryTokenStorage(),
  // Call refresh method!
  refreshToken: (token, httpClient) => Future.value(
    const OAuth2Token(accessToken: ""),
  ),
  // Check error response to confirm if it needs to call refresh.
  shouldRefresh: (response) => false,
);

class RequestHandler {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConfig.baseURl,
      receiveDataWhenStatusError: true,
      validateStatus: (status) => true,
    ),
  )..interceptors.add(_fresh);

  Dio get dio => _dio;
  String get mainUrl => APIConfig.baseURl;

  Future<Response> post(
    String url,
    dynamic params, {
    bool tokenNeeded = true,
    String? errorMsg,
    String? baseUrl,
    Options? options,
    Map<String, dynamic>? queryParams,
  }) {
    try {
      return dio.post(
        (baseUrl ?? mainUrl) + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (error, stacktrace) {
      throw RequestException(
        method: "/POST",
        url: (baseUrl ?? mainUrl) + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stacktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stacktrace) {
      throw RequestException(
        method: "/POST",
        url: (baseUrl ?? mainUrl) + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stacktrace,
      );
    }
  }

  Future<Response> get(
    String url, {
    bool tokenNeeded = true,
    String? errorMsg,
    String? baseUrl,
    Options? options,
    Map<String, dynamic>? queryParams,
  }) {
    try {
      return dio.get(
        (baseUrl ?? mainUrl) + url,
        options: options,
        queryParameters: queryParams,
      );
    } on DioException catch (error, stacktrace) {
      throw RequestException(
        method: "/GET",
        url: (baseUrl ?? mainUrl) + url,
        error: error,
        msg: errorMsg,
        trace: stacktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stacktrace) {
      throw RequestException(
        method: "/GET",
        url: (baseUrl ?? mainUrl) + url,
        msg: errorMsg,
        error: error,
        trace: stacktrace,
      );
    }
  }

  Future<Response> put(
    String url,
    Map<String, dynamic> params, {
    bool tokenNeeded = true,
    String? errorMsg,
    String? baseUrl,
    Options? options,
    Map<String, dynamic>? queryParams,
  }) {
    try {
      return dio.put(
        (baseUrl ?? mainUrl) + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (error, stacktrace) {
      throw RequestException(
        method: "/PUT",
        url: (baseUrl ?? mainUrl) + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stacktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stacktrace) {
      throw RequestException(
        method: "/PUT",
        url: (baseUrl ?? mainUrl) + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stacktrace,
      );
    }
  }

  Future<Response> delete(
    String url,
    Map<String, dynamic> params, {
    bool tokenNeeded = true,
    String? errorMsg,
    String? baseUrl,
    Options? options,
    Map<String, dynamic>? queryParams,
  }) {
    try {
      return dio.delete(
        (baseUrl ?? mainUrl) + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (error, stacktrace) {
      throw RequestException(
        method: "/DELETE",
        url: (baseUrl ?? mainUrl) + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stacktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stacktrace) {
      throw RequestException(
        method: "/DELETE",
        url: (baseUrl ?? mainUrl) + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stacktrace,
      );
    }
  }
}

/// NOTE: JUST FOR TESTING & HANDLING RESPONSE!
typedef EmptyType = String;
// ignore: constant_identifier_names
const EMPTY = "EMPTY";

class RequestException implements Exception {
  String url;
  String? msg;
  Object error;
  String method;
  Response? res;
  int? statusCode;
  StackTrace trace;
  dynamic data;

  RequestException({
    this.msg,
    this.res,
    this.data,
    this.statusCode,
    required this.url,
    required this.method,
    required this.error,
    required this.trace,
  }) {
    final details = "\x1B[35m/*\n"
        "method: ($method)\n"
        "url: ($url)\n"
        "statusCode: ${statusCode ?? 0}\n"
        "errorMsg: \"${msg ?? ''}\"\n"
        "data: ${data ?? ''}\n"
        "res: ${res ?? ''}\n"
        "*/\x1B[0m\n";

    log(details, name: "#RequestException", error: error, stackTrace: trace);
  }

  handleError({required String defaultMessage}) async {
    try {
      if (res != null) {
        final pursedData = ResponseWrapper<EmptyType>.fromMap(
          rawResponse: res!,
          purserFunction: (rawData) => EMPTY,
        );
        if (pursedData.isSuccess) {
          /* Means Purser caused the error! */
          showToastError(
            pursedData.error?.firstOrNull?.description ?? pursedData.msg,
          );
        } else {
          /* Means Server didn't sent valid data! */
          showToastError(defaultMessage);
        }
      }
    } catch (e) {
      showToastError(defaultMessage);
      log(
        '# Response is not a [Map<String, dynamic>]! instead ${res?.data.runtimeType}',
        error: e,
      );
    }
  }
}
