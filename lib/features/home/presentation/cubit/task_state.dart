import 'package:equatable/equatable.dart';
import 'package:zbooma_task/features/home/data/models/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskGetAllLoading extends TaskState {}

class TaskGetAllSuccess extends TaskState {
  final List<TaskModel> tasks;

  final int currentPage;
  final bool hasMorePages;
  const TaskGetAllSuccess({
    required this.tasks,
    required this.currentPage,
    required this.hasMorePages,
  });

  @override
  List<Object> get props => [identityHashCode(this)];
}

class TaskFilterLoading extends TaskState {}

class TaskFilterPaginationLoading extends TaskState {}

class TaskFilterSuccess extends TaskState {
  final List<TaskModel> tasks;
  final int currentPage;
  final bool hasMorePages;
  final String priority;

  const TaskFilterSuccess({
    required this.tasks,
    required this.currentPage,
    required this.hasMorePages,
    required this.priority,
  });
}

class TaskFilterError extends TaskState {
  final String error;

  const TaskFilterError({required this.error});
}

class TaskGetAllError extends TaskState {
  final String error;
  const TaskGetAllError({required this.error});
}

class TaskGetMoreLoading extends TaskState {}

class TaskGetMoreSuccess extends TaskState {
  final List<TaskModel> tasks;
  const TaskGetMoreSuccess(this.tasks);
}

class TaskGetMoreError extends TaskState {
  final String error;
  const TaskGetMoreError({required this.error});
}

class TaskGetByIdLoading extends TaskState {}

class TaskGetByIdSuccess extends TaskState {
  final TaskModel task;
  const TaskGetByIdSuccess(this.task);
}

class TaskGetByIdError extends TaskState {
  final String error;
  const TaskGetByIdError({required this.error});
}

class TaskCreateLoading extends TaskState {}

class TaskCreateSuccess extends TaskState {
  final TaskModel task;
  const TaskCreateSuccess(this.task);
}

class TaskCreateError extends TaskState {
  final String error;
  const TaskCreateError({required this.error});
}

class TaskUpdateLoading extends TaskState {}

class TaskUpdateSuccess extends TaskState {
  final TaskModel taskModel;

  const TaskUpdateSuccess(this.taskModel);
}

class TaskUpdateError extends TaskState {
  final String error;

  const TaskUpdateError({required this.error});
}

class TaskDeleteLoading extends TaskState {}

class TaskDeleteSuccess extends TaskState {
  final String id;

  const TaskDeleteSuccess(this.id);
}

class TaskDeleteError extends TaskState {
  final String error;

  const TaskDeleteError({required this.error});
}
