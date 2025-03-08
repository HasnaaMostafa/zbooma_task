import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/utils/widgets/empty/empty_widget.dart';
import 'package:zbooma_task/core/utils/widgets/shimmer/loading_widget.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_cubit.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_state.dart';
import 'package:zbooma_task/features/home/presentation/widgets/category_listview.dart';
import 'package:zbooma_task/features/home/presentation/widgets/fab_icon.dart';
import 'package:zbooma_task/features/home/presentation/widgets/home_appbar.dart';
import 'package:zbooma_task/features/home/presentation/widgets/task_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  late TaskCubit _taskCubit;
  bool _isLoading = false;
  String _currentPriority = "all";

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        _loadMoreTasks();
      }
    });
  }

  void _loadMoreTasks() {
    if (_isLoading) return;

    _isLoading = true;

    if (_currentPriority == "all") {
      if (_taskCubit.hasMorePages) {
        _taskCubit.getAllTasks().then((_) {
          _isLoading = false;
        });
      } else {
        _isLoading = false;
      }
    } else {
      if (_taskCubit.hasMoreFilteredPages) {
        _taskCubit.getFilteredTasks(priority: _currentPriority).then((_) {
          _isLoading = false;
        });
      } else {
        _isLoading = false;
      }
    }
  }

  Future<void> _refreshTasks() async {
    if (_currentPriority == "all") {
      _taskCubit.currentPage = 1;
      _taskCubit.hasMorePages = true;
      return _taskCubit.getAllTasks();
    } else {
      return _taskCubit.refreshFilteredTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FabIcon(),
      appBar: HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: BlocProvider(
          create: (context) {
            _taskCubit = TaskCubit(sl())..getAllTasks();
            _setupScrollListener();
            return _taskCubit;
          },
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Tasks",
                    style: AppStyles.bold16White.copyWith(
                      color: Color(0xff24252C).withValues(alpha: 0.6),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CategoryListView(
                    onChangePriority: (value) {
                      if (_currentPriority != value) {
                        setState(() {
                          _currentPriority = value ?? "";
                        });

                        if (value == "all") {
                          _taskCubit.clearFilters();
                        } else {
                          _taskCubit.getFilteredTasks(
                            priority: value ?? "",
                            refresh: true,
                          );
                        }
                      }
                    },
                  ),
                  Expanded(
                    child: TasksListWidget(
                      state: state,
                      taskCubit: _taskCubit,
                      currentPriority: _currentPriority,
                      refreshTasks: _refreshTasks,
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TasksListWidget extends StatelessWidget {
  final TaskState state;
  final TaskCubit _taskCubit;
  final String _currentPriority;
  final Future<void> Function() _refreshTasks;
  final ScrollController _scrollController;

  const TasksListWidget({
    super.key,
    required this.state,
    required TaskCubit taskCubit,
    required String currentPriority,
    required Future<void> Function() refreshTasks,
    required ScrollController scrollController,
  }) : _taskCubit = taskCubit,
       _currentPriority = currentPriority,
       _refreshTasks = refreshTasks,
       _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    if ((state is TaskGetAllLoading && _taskCubit.currentPage == 1) ||
        state is TaskFilterLoading) {
      return CustomLoadingWidget();
    }
    if ((state is TaskGetAllError && _taskCubit.currentPage == 1) ||
        state is TaskFilterError) {
      final String errorMessage =
          state is TaskGetAllError
              ? (state as TaskGetAllError).error.toString()
              : (state as TaskFilterError).error.toString();
      return Center(child: Text(errorMessage));
    }
    List<dynamic> tasks = [];
    bool hasMore = false;

    if (state is TaskGetAllSuccess) {
      tasks = (state as TaskGetAllSuccess).tasks;
      hasMore = (state as TaskGetAllSuccess).hasMorePages;
    } else if (state is TaskFilterSuccess) {
      tasks = (state as TaskFilterSuccess).tasks;
      hasMore = (state as TaskFilterSuccess).hasMorePages;
    } else if (_taskCubit.filteredTasks.isNotEmpty &&
        _currentPriority != "all") {
      tasks = _taskCubit.filteredTasks;
      hasMore = _taskCubit.hasMoreFilteredPages;
    } else if (_taskCubit.allTasks.isNotEmpty && _currentPriority == "all") {
      tasks = _taskCubit.allTasks;
      hasMore = _taskCubit.hasMorePages;
    }

    if (tasks.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refreshTasks,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: EmptyWidget(title: "No Tasks Found"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshTasks,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: tasks.length + (hasMore ? 1 : 0),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index < tasks.length) {
            return TaskItem(taskModel: tasks[index]);
          } else if (hasMore) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomLoadingWidget(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
