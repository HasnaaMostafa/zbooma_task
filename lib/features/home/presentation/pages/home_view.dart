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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FabIcon(),
      appBar: HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
        child: BlocProvider(
          create: (context) => TaskCubit(sl())..getAllTasks(),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskGetAllSuccess) {
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
                        itemCount: state.tasks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return TaskItem(taskModel: state.tasks[index]);
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
