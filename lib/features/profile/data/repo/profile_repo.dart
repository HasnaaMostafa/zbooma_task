import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zbooma_task/core/api/api_service.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/errors/failure.dart';
import 'package:zbooma_task/core/errors/server_failure.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/features/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getUserData();
  Future<Either<Failure, bool>> logout();
}

class ProfileRepoImpl implements ProfileRepo {
  final TaskPreferences preferences;

  ProfileRepoImpl(this.preferences);
  @override
  Future<Either<Failure, ProfileModel>> getUserData({String? newToken}) async {
    try {
      String? token = preferences.getToken();
      var response = await ApiServices.getData(
        endPoint: EndPoints.profile,
        token: newToken ?? token,
      );
      log(token.toString());

      log(response.toString());
      if (kDebugMode) {
        print(response.data);
      }
      final ProfileModel profileData = ProfileModel.fromJson(response.data);
      return Right(profileData);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      String? refreshToken = preferences.getRefreshToken();
      String? token = preferences.getToken();
      var response = await ApiServices.postData(
        endPoint: EndPoints.logout,
        data: {'token': refreshToken},
        token: token,
      );
      log(token.toString());

      log(response.toString());
      if (kDebugMode) {
        print(response.data);
      }
      preferences.deleteToken();
      preferences.deleteRefreshToken();
      preferences.deleteUserId();
      return Right(true);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
