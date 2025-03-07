import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
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

  @override
  void initState() {
    super.initState();
    _taskCubit = TaskCubit(sl());

    // Add scroll listener
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  bool _isLoadingMore = false;

  void _onScroll() {
    // Check if we're near the bottom (80% of the way down)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // Load more if not already loading and not at the last page
      final taskCubit = context.read<TaskCubit>();
      if (!_isLoadingMore && !taskCubit.isLastPage) {
        _isLoadingMore = true;
        taskCubit.loadMoreTasks();
        // Reset the loading flag after a short delay
        Future.delayed(Duration(milliseconds: 500), () {
          _isLoadingMore = false;
        });
      }
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
            _taskCubit.getAllTasks();
            return _taskCubit;
          },
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              // Optional: You can add listener logic here if needed
            },
            builder: (context, state) {
              final taskCubit = context.read<TaskCubit>();

              if (state is TaskGetAllSuccess ||
                  state is TaskGetMoreSuccess ||
                  state is TaskGetMoreLoading) {
                final tasks = taskCubit.tasks;
                final isLoadingMore = state is TaskGetMoreLoading;

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
                    CategoryListView(),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: tasks.length + (isLoadingMore ? 1 : 0),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Show loading indicator at the bottom when loading more
                          if (index == tasks.length && isLoadingMore) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          // Regular task item
                          return TaskItem(taskModel: tasks[index]);
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is TaskGetAllLoading) {
                return CustomLoadingWidget();
              } else if (state is TaskGetAllError) {
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
