import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/features/home/data/models/task_model.dart';
import 'package:zbooma_task/features/home/data/repo/task_repo.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.taskRepo) : super(TaskInitial());

  final TaskRepo taskRepo;

  static TaskCubit get(context) => BlocProvider.of(context);

  List<TaskModel> tasks = [];
  bool isLastPage = false;
  int currentPage = 1;
  Set<String> taskIds = {};

  void getAllTasks({int page = 1, bool loadMore = false}) async {
    if (!loadMore) {
      emit(TaskGetAllLoading());
    } else {
      emit(TaskGetMoreLoading());
    }

    var response = await taskRepo.getAllTasks(page: page);

    response.fold(
      (error) {
        emit(TaskGetAllError(error: error.errMessage.toString()));
      },
      (tasksList) {
        if (loadMore) {
          if (tasksList.isEmpty) {
            isLastPage = true;
          } else {
            tasks.addAll(tasksList);
            taskIds.addAll(tasksList.map((task) => task.id ?? ""));
            currentPage = page;
          }
          emit(TaskGetMoreSuccess(tasks));
        } else {
          tasks = tasksList;
          currentPage = page;
          isLastPage = tasksList.isEmpty;
          emit(TaskGetAllSuccess(tasks));
        }
      },
    );
  }

  void loadMoreTasks() {
    if (!isLastPage) {
      getAllTasks(page: currentPage + 1, loadMore: true);
    }
  }

  void refreshTasks() {
    currentPage = 1;
    isLastPage = false;
    getAllTasks(page: 1);
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
        tasks.add(createdTask);
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
        final index = tasks.indexWhere((task) => task.id == updatedTask.id);
        if (index != -1) {
          tasks[index] = updatedTask;
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
        tasks.removeWhere((task) => task.id == id);
        taskIds.remove(id);

        emit(TaskDeleteSuccess(id));
      },
    );
  }
}
