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
List<TaskModel> filteredTasks = []; 

String currentPriority = "all";

Future<void> getAllTasks() async {
  if (currentPriority != "all" || !hasMorePages) return;
  
  if (currentPage == 1) {
    allTasks.clear();
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
            if (currentPriority == "all") {
        filteredTasks = allTasks;
      } else {
        filteredTasks = allTasks.where((task) => task.priority == currentPriority).toList();
      }
      
      emit(
        TaskGetAllSuccess(
          hasMorePages: currentPriority == "all" ? hasMorePages : false,
          tasks: filteredTasks,
          currentPage: currentPage,
        ),
      );
      
      currentPage++;
    },
  );
}

void filterTasksByPriority(String priority) {
  currentPriority = priority;
  
  if (priority == "all") {
    filteredTasks = allTasks;
    emit(
      TaskGetAllSuccess(
        tasks: filteredTasks,
        currentPage: currentPage,
        hasMorePages: hasMorePages,
      ),
    );
  } else {
    filteredTasks = allTasks.where((task) => task.priority == priority).toList();
    emit(
      TaskGetAllSuccess(
        tasks: filteredTasks,
        currentPage: currentPage,
        hasMorePages: false, 
      ),
    );
  }
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
