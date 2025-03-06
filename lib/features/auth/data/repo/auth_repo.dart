import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zbooma_task/core/api/api_service.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/errors/failure.dart';
import 'package:zbooma_task/core/errors/server_failure.dart';
import 'package:zbooma_task/features/auth/data/models/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required String password,
  });
}

class AuthRepoImpl implements AuthRepo{
  @override
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        "phone": phone,
        "password": password,
      };
      var response = await ApiServices.postData(
        endPoint: EndPoints.login,
        data: data,
      );
      if (kDebugMode) {
        print(response.data);
      }
      final LoginModel loginModel = LoginModel.fromJson(response.data);
      return Right(loginModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
  
}