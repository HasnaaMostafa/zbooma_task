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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        if (!_isLoading && _taskCubit.hasMorePages) {
          _isLoading = true;
          _taskCubit.getAllTasks().then((_) {
            _isLoading = false;
          });
        }
      }
    });
  }

  String? priority;

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
            return _taskCubit;
          },
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is TaskGetAllSuccess && _taskCubit.currentPage == 2) {
                _setupScrollListener();
              }
            },
            builder: (context, state) {
              if (state is TaskGetAllSuccess || state is TasksFilteredSuccess) {
                final tasks =
                    state is TaskGetAllSuccess
                        ? state.tasks
                        : (state as TasksFilteredSuccess).tasks;

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
                        setState(() {
                          priority = value;
                        });
                      },
                    ),
                    if (tasks.isNotEmpty)
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _taskCubit.currentPage = 1;
                            _taskCubit.hasMorePages = true;
                            return Future(() {
                              _taskCubit.getAllTasks();
                            });
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                tasks.length +
                                (_taskCubit.hasMorePages ? 1 : 0),
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < tasks.length) {
                                return TaskItem(taskModel: tasks[index]);
                              } else {
                                if (priority == "all") {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    if (tasks.isEmpty)
                      Expanded(child: EmptyWidget(title: "No data")),
                  ],
                );
              } else if (state is TaskGetAllLoading &&
                  _taskCubit.currentPage == 1) {
                return CustomLoadingWidget();
              } else if (state is TaskGetAllError &&
                  _taskCubit.currentPage == 1) {
                return Center(child: Text(state.error.toString()));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
