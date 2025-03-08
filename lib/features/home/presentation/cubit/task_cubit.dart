import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/features/home/data/models/task_model.dart';
import 'package:zbooma_task/features/home/data/repo/task_repo.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.taskRepo) : super(TaskInitial());

  final TaskRepo taskRepo;

  static TaskCubit get(context) => BlocProvider.of(context);
  bool hasMorePages = true;
  int currentPage = 1;
  List<TaskModel> allTasks = [];

  bool hasMoreFilteredPages = true;
  int currentFilteredPage = 1;
  List<TaskModel> filteredTasks = [];
  String currentPriority = "all";

  Future<void> getAllTasks() async {
    if (!hasMorePages) return;

    if (currentPage == 1) {
      allTasks.clear();
      filteredTasks.clear();
      currentFilteredPage = 1;
      emit(TaskGetAllLoading());
    }

    final response = await taskRepo.getAllTasks(page: currentPage);

    return response.fold(
      (error) {
        emit(TaskGetAllError(error: error.errMessage.toString()));
        log(error.toString());
      },
      (items) {
        if (items.isEmpty || items.length < 20) {
          hasMorePages = false;
        }

        allTasks.addAll(items);

        emit(
          TaskGetAllSuccess(
            hasMorePages: hasMorePages,
            tasks: allTasks,
            currentPage: currentPage,
          ),
        );

        currentPage++;
      },
    );
  }

  Future<void> getFilteredTasks({
    required String priority,
    bool refresh = false,
  }) async {
    if (refresh || currentPriority != priority) {
      currentFilteredPage = 1;
      hasMoreFilteredPages = true;
      filteredTasks.clear();
      allTasks.clear();
      currentPage = 1;
      currentPriority = priority;
    }
    if (!hasMoreFilteredPages) return;

    if (currentFilteredPage == 1) {
      emit(TaskFilterLoading());
    } else {
      emit(TaskFilterPaginationLoading());
    }
    final response = await taskRepo.getFilteredTasks(
      priority: priority,
      page: currentFilteredPage,
    );
    // log("filteredTasks cleared: ${filteredTasks.length}");
    // log("allTasks updated: ${filteredTasks.length}");
    filteredTasks.clear();
    allTasks.clear();

    return response.fold(
      (error) {
        emit(TaskFilterError(error: error.errMessage.toString()));
        log(error.toString());
      },
      (items) {
        if (items.isEmpty || items.length < 20) {
          hasMoreFilteredPages = false;
        }

        filteredTasks.addAll(items);

        emit(
          TaskFilterSuccess(
            hasMorePages: hasMoreFilteredPages,
            tasks: filteredTasks,
            currentPage: currentFilteredPage,
            priority: priority,
          ),
        );

        currentFilteredPage++;
      },
    );
  }

  Future<void> refreshFilteredTasks() async {
    if (currentPriority == "all") {
      currentPage = 1;
      hasMorePages = true;
      allTasks.clear();
      filteredTasks.clear();
      return getAllTasks();
    } else {
      return getFilteredTasks(priority: currentPriority, refresh: true);
    }
  }

  void clearFilters() {
    currentPriority = "all";
    currentPage = 1;
    hasMorePages = true;
    filteredTasks.clear();
    allTasks.clear();
    getAllTasks();
  }

  void getTaskById(String id) async {
    emit(TaskGetByIdLoading());

    var response = await taskRepo.getTaskById(id);

    response.fold(
      (error) {
        emit(TaskGetByIdError(error: error.errMessage.toString()));
      },
      (task) {
        emit(TaskGetByIdSuccess(task));
      },
    );
  }

  void createTask({
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String endDate,
  }) async {
    emit(TaskCreateLoading());

    var response = await taskRepo.createTask(
      title: title,
      desc: desc,
      priority: priority,
      image: image,
      endDate: endDate,
    );

    response.fold(
      (error) {
        emit(TaskCreateError(error: error.errMessage.toString()));
      },
      (createdTask) {
        allTasks.add(createdTask);
        emit(TaskCreateSuccess(createdTask));
      },
    );
  }

  Future<void> updateTask({
    required String id,
    required String title,
    required String desc,
    required String priority,
    required String image,
    required String status,
  }) async {
    emit(TaskUpdateLoading());

    final response = await taskRepo.updateTask(
      id: id,
      title: title,
      desc: desc,
      priority: priority,
      image: image,
      status: status,
    );

    response.fold(
      (error) {
        emit(TaskUpdateError(error: error.errMessage.toString()));
      },
      (updatedTask) {
        final index = allTasks.indexWhere((task) => task.id == updatedTask.id);
        if (index != -1) {
          allTasks[index] = updatedTask;
        }

        emit(TaskUpdateSuccess(updatedTask));
      },
    );
  }

  Future<void> deleteTask({required String id}) async {
    emit(TaskDeleteLoading());

    final response = await taskRepo.deleteTask(id: id);

    response.fold(
      (error) {
        emit(TaskDeleteError(error: error.errMessage.toString()));
      },
      (_) {
        allTasks.removeWhere((task) => task.id == id);
        // taskIds.remove(id);

        emit(TaskDeleteSuccess(id));
      },
    );
  }
}
