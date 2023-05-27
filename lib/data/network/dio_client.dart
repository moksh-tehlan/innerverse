import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innerverse/data/network/collections.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient(this._dio) {
    _dio
      ..options.connectTimeout = Collections.connectionTimeout
      ..options.receiveTimeout = Collections.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers['Authorization'] = Collections.key
      ..options.headers['Content-Type'] = 'application/json'
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioError error, ErrorInterceptorHandler handler) async {
            handler.reject(error);
            if (error.type == DioErrorType.unknown &&
                error.error is SocketException) {
              await Fluttertoast.showToast(
                msg: 'Please check your internet connection',
              );
            }
            if (error.type == DioErrorType.connectionTimeout ||
                error.type == DioErrorType.receiveTimeout) {
              await Fluttertoast.showToast(
                msg: 'Servers are busy please recheck in a while',
              );
            }
          },
        ),
      );
  }
  final Dio _dio;

  Future<Response<dynamic>> post(
    String url, {
    required Map<String,dynamic> data,
  }) async {
      final response = await _dio.post<dynamic>(
        url,
        data: data,
      );
      return response;
  }
}
