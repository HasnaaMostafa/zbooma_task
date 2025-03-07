import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:zbooma_task/core/api/api_service.dart';
import 'package:zbooma_task/core/api/end_points.dart';
import 'package:zbooma_task/core/errors/failure.dart';
import 'package:zbooma_task/core/errors/server_failure.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/features/home/data/models/task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, List<TaskModel>>> getAllTasks({int page = 1});
  Future<Either<Failure, TaskModel>> getTaskById(String id);
  Future<Either<Failure, TaskModel>> createTask({
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String endDate,
  });
   Future<Either<Failure, TaskModel>> updateTask({
    required String id,
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String status,
    required String userId,

  });
  Future<Either<Failure, void>> deleteTask({required String id});
}

class TaskRepoImpl implements TaskRepo {
  final TaskPreferences preferences;

  TaskRepoImpl(this.preferences);

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks({int page = 1}) async {
    try {
      String? token = preferences.getToken();
      var response = await ApiServices.getData(
        endPoint: EndPoints.task,
        query: {"page": page},
        token: token,
      );

      if (kDebugMode) {
        print("Tasks response: ${response.data}");
      }

      List<TaskModel> tasks =
          (response.data as List)
              .map((task) => TaskModel.fromJson(task))
              .toList();

      return Right(tasks);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> getTaskById(String id) async {
    try {
      String? token = preferences.getToken();
      var response = await ApiServices.getData(
        endPoint: "${EndPoints.task}/$id",
        token: token,
      );

      if (kDebugMode) {
        print("Task response: ${response.data}");
      }

      final TaskModel task = TaskModel.fromJson(response.data);
      return Right(task);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> createTask({
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String endDate,
  }) async {
    try {
      String? token = preferences.getToken();

      Map<String, dynamic> data = {
        "image": image,
        "title": title,
        "desc": desc,
        "priority": priority,
        "dueDate": endDate,
      };

      var response = await ApiServices.postData(
        endPoint: EndPoints.task,
        data: data,
        token: token,
      );

      if (kDebugMode) {
        print("Create task response: ${response.data}");
      }

      final TaskModel createdTask = TaskModel.fromJson(response.data);
      return Right(createdTask);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTask({
    required String id,
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String status,
    required String userId,
  }) async {
    try {
      String? token = preferences.getToken();

      Map<String, dynamic> data = {
        "image": image,
        "title": title,
        "desc": desc,
        "priority": priority,
        "status": status,
        "user": userId
};

      var response = await ApiServices.putData(
        endPoint: "${EndPoints.task}/$id",
        data: data,
        token: token,
      );

      if (kDebugMode) {
        print("Update task response: ${response.data}");
      }

      final TaskModel updatedTask = TaskModel.fromJson(response.data);
      return Right(updatedTask);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String id}) async {
    try {
      String? token = preferences.getToken();

      var response = await ApiServices.deleteData(
        endPoint: "${EndPoints.task}/$id",
        token: token,
      );

      if (kDebugMode) {
        print("Delete task response: ${response.statusCode}");
      }

      return const Right(null);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

}
