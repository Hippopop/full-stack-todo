import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/constants/server/api/api_config.dart';
import 'package:todo_client/src/repository/source/response_wrapper.dart';
import 'package:todo_client/src/utilities/scaffold_utilities.dart';

final requestHandlerProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});

class RequestHandler {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: APIConfig.baseURl,
    ),
  );

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
  }) async {
    try {
      final response = await dio.post(
        baseUrl ?? mainUrl + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
      return response;
    } on DioError catch (error, stracktrace) {
      throw RequestException(
        method: "/POST",
        url: baseUrl ?? mainUrl + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stracktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stracktrace) {
      throw RequestException(
        method: "/POST",
        url: baseUrl ?? mainUrl + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stracktrace,
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
  }) async {
    try {
      final response = await dio.get(
        baseUrl ?? mainUrl + url,
        options: options,
        queryParameters: queryParams,
      );
      return response;
    } on DioError catch (error, stracktrace) {
      throw RequestException(
        method: "/GET",
        url: baseUrl ?? mainUrl + url,
        error: error,
        msg: errorMsg,
        trace: stracktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stracktrace) {
      throw RequestException(
        method: "/GET",
        url: baseUrl ?? mainUrl + url,
        msg: errorMsg,
        error: error,
        trace: stracktrace,
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
  }) async {
    Response response;
    try {
      response = await dio.put(
        baseUrl ?? mainUrl + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
      return response;
    } on DioError catch (error, stracktrace) {
      throw RequestException(
        method: "/PUT",
        url: baseUrl ?? mainUrl + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stracktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stracktrace) {
      throw RequestException(
        method: "/PUT",
        url: baseUrl ?? mainUrl + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stracktrace,
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
  }) async {
    Response response;
    try {
      response = await dio.delete(
        baseUrl ?? mainUrl + url,
        data: params,
        queryParameters: queryParams,
        options: options,
      );
      return response;
    } on DioError catch (error, stracktrace) {
      throw RequestException(
        method: "/DELETE",
        url: baseUrl ?? mainUrl + url,
        data: params,
        error: error,
        msg: errorMsg,
        trace: stracktrace,
        res: error.response,
        statusCode: error.response?.statusCode,
      );
    } catch (error, stracktrace) {
      throw RequestException(
        method: "/DELETE",
        url: baseUrl ?? mainUrl + url,
        msg: errorMsg,
        data: params,
        error: error,
        trace: stracktrace,
      );
    }
  }
}

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
    final details = """\x1B[35m/*
    method: ($method)
    url: ($url)
    statusCode: ${statusCode ?? 0}
    errorMsg: "${msg ?? ''}"
    data: ${data ?? ''}
    res: ${res ?? ''}
  */\x1B[0m""";

    log(
      details,
      name: "#RequestException",
      time: DateTime.now(),
      error: error,
      stackTrace: trace,
    );
  }

  handleError({required String defaultMessage}) {
    try {
      final pursedData = ResponseWrapper.fromMap(res?.data);
      if (pursedData.isSuccess) {
        showToastError(pursedData.msg);
      }
    } catch (e) {
      log(
        '# Response is not a [Map<String, dynamic>]! instead ${res?.data.runtimeType}',
        error: e,
      );
    }
  }
}
