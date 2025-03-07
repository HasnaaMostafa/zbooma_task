import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zbooma_task/core/api/api_service.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/errors/failure.dart';
import 'package:zbooma_task/core/errors/server_failure.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/features/auth/data/models/auth_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> login({
    required String phone,
    required String password,
  });

  Future<Either<Failure, AuthModel>> register({
    required String phone,
    required String password,
    required String name,
    required int experiences,
    required String level,
    required String address,
  });
}

class AuthRepoImpl implements AuthRepo {
  final TaskPreferences preferences;

  AuthRepoImpl(this.preferences);
  @override
  Future<Either<Failure, AuthModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {"phone": phone, "password": password};
      var response = await ApiServices.postData(
        endPoint: EndPoints.login,
        data: data,
      );
      if (kDebugMode) {
        print(response.data);
      }
      final AuthModel loginModel = AuthModel.fromJson(response.data);

      preferences.saveToken(loginModel.accessToken ?? "");
      preferences.saveRefreshToken(loginModel.refreshToken ?? "");
      print(loginModel.accessToken ?? "");
      return Right(loginModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> register({
    required String phone,
    required String password,
    required String name,
    required int experiences,
    required String level,
    required String address,
  }) async {
    try {
      Map<String, dynamic> data = {
        "phone": phone,
        "password": password,
        "displayName": name,
        "experienceYears": experiences,
        "address": address,
        "level": level,
      };
      var response = await ApiServices.postData(
        endPoint: EndPoints.register,
        data: data,
      );

      log(
        ApiServices.postData(
          endPoint: EndPoints.register,
          data: data,
        ).toString(),
      );
      log(response.toString());
      if (kDebugMode) {
        print(response.data);
      }
      final AuthModel registerModel = AuthModel.fromJson(response.data);

      preferences.saveToken(registerModel.accessToken ?? "");
      preferences.saveRefreshToken(registerModel.refreshToken ?? "");
      return Right(registerModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
