import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zbooma_task/app.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/features/auth/presentation/pages/login_view.dart';

class ApiServices {
  static late Dio dio;
  static late TaskPreferences preferences;

  static final List<({RequestOptions options, ErrorInterceptorHandler handler})>
  _requestQueue = [];

  static init() {
    dio = Dio(BaseOptions(baseUrl: "https://todo.iraqsapp.com"));
    preferences = TaskPreferences(sl());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = preferences.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (kDebugMode) {
            log(e.response?.statusMessage.toString() ?? "");
            log(e.response?.statusCode.toString() ?? "");
            log("----------error-----------");
          }

          if (e.response?.statusMessage?.toLowerCase().contains(
                    "unauthorized",
                  ) ==
                  true &&
              e.response?.statusCode == 401) {
            _requestQueue.add((options: e.requestOptions, handler: handler));

            String? refreshToken = preferences.getRefreshToken();
            if (refreshToken != null) {
              try {
                final response = await ApiServices.getData(
                  endPoint: EndPoints.refreshToken,
                  query: {"token": refreshToken},
                );

                if (kDebugMode) {
                  print(response.data);
                }

                await preferences.saveToken(response.data['access_token']);
                await preferences.saveRefreshToken(refreshToken);

                // ProfileCubit.get(navigatorKey.currentState!.context).getUserData(
                //   token: response.data['access_token'],
                // );

                if (kDebugMode) {
                  print("Refresh Token Success");
                }

                for (final request in _requestQueue) {
                  try {
                    request.options.headers['Authorization'] =
                        'Bearer ${response.data['access_token']}';

                    final retryResponse = await dio.request(
                      request.options.path,
                      data: request.options.data,
                      queryParameters: request.options.queryParameters,
                      options: Options(
                        method: request.options.method,
                        headers: request.options.headers,
                      ),
                    );

                    request.handler.resolve(retryResponse);
                  } catch (retryError) {
                    if (!request.handler.isCompleted) {
                      request.handler.reject(
                        DioException(
                          requestOptions: request.options,
                          error: retryError,
                        ),
                      );
                    }
                  }
                }

                _requestQueue.clear();

                // return handler.resolve(response);
              } catch (refreshError) {
                if (kDebugMode) {
                  print("Refresh Token Failed: $refreshError");
                }

                _requestQueue.clear();
                return handler.reject(
                  DioException(
                    requestOptions: e.requestOptions,
                    error: refreshError,
                  ),
                );
              }
            }
          } else if (e.response?.statusCode == 403 ||
              e.response?.statusMessage?.contains("Forbidden") == true) {
            await preferences.deleteToken();
            await preferences.deleteRefreshToken();
            showToast(
              message: "Login Has Expired",
              state: ToastStates.loginExpired,
            );
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginView()),
              (route) => false,
            );
            return handler.reject(e);
          }
        },
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "accept": "application/json",
    };
    var response = await dio.get(endPoint, queryParameters: query);
    return response;
  }

  static Future<Response> logout({
    required String endPoint,
    String? token,
    String? lang = "en",
  }) async {
    dio.options.headers = {
      "accept": "*/*",
      "lang": lang,
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    var response = await dio.post(endPoint);
    return response;
  }

  static Future<Response> patchFormData({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": "Bearer $token",
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
    };
    return await dio.patch(endPoint, queryParameters: query, data: formData);
  }

  static Future<Response> patchData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      'Content-Type': 'application/json',
      "Accept": "application/json",
    };
    return await dio.patch(endPoint, queryParameters: query, data: data);
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
      "accept": "application/json",
    };
    var response = await dio.post(endPoint, queryParameters: query, data: data);
    return response;
  }

  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json",
    };
    return await dio.put(endPoint, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token,
      "Content-Type": "application/json",
    };
    return await dio.delete(endPoint, queryParameters: query);
  }
}
