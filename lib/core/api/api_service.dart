import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zbooma_task/app.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/features/auth/presentation/pages/login_view.dart';
import 'package:zbooma_task/features/profile/presentation/cubit/profile_cubit.dart';

class ApiServices {
  static late Dio dio;

  static late TaskPreferences preferences;

  static init() {
    dio = Dio(BaseOptions(baseUrl: "https://todo.iraqsapp.com"));
    preferences = TaskPreferences(sl());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (kDebugMode) {
            print(e.response?.statusMessage);
          }
          if (e.response?.statusCode == 401 &&
              e.response.toString().contains("Unauthorized")) {
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

                ProfileCubit.get(
                  navigatorKey.currentState!.context,
                ).getUserData(token: response.data['access_token']);

                return handler.resolve(response);
              } catch (refreshError) {
                return handler.reject(
                  DioException(
                    requestOptions: RequestOptions(data: refreshError),
                  ),
                );
              }
            }
          } else if (e.response.toString().contains("Invalid refresh token")) {
            await preferences.deleteToken();
            await preferences.deleteRefreshToken();
            showToast(message: "Login Has Expired", state: ToastStates.message);
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginView()),
              (route) => false,
            );
          }
          return handler.reject(e);
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
