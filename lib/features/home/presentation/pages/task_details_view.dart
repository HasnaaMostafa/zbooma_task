import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/function/format_date.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_date_textfield.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/shimmer/loading_widget.dart';
import 'package:zbooma_task/features/auth/presentation/cubit/constants.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_cubit.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_state.dart';

class TaskDetailsView extends StatefulWidget {
  const TaskDetailsView({super.key, required this.id});

  final String id;

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Task Details", isMenu: true),
      body: BlocProvider(
        create: (context) => TaskCubit(sl())..getTaskById(widget.id),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskGetByIdSuccess) {
              TextEditingController dateController = TextEditingController();
              final String dateString = state.task.createdAt.toString();
              final String formattedDate = formatDate(dateString);
              dateController.text = formattedDate;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Image.network(defaultImage, height: 255.h),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.task.title ?? "",
                            style: AppStyles.bold24black,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.task.desc ?? "",
                            style: AppStyles.regular14Grey6E.copyWith(
                              color: Color(0xff24252C).withValues(alpha: 0.6),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomDateTextField(
                            isFilled: true,
                            dateController: dateController,
                            title: "End Date",
                          ),
                          CustomDropdownTextField(
                            style: AppStyles.bold16White.copyWith(
                              color: AppColors.primary,
                            ),
                            labelText:
                                state.task.status != null
                                    ? state.task.status![0].toUpperCase() +
                                        state.task.status!
                                            .substring(1)
                                            .toLowerCase()
                                    : "",
                            labelStyle: AppStyles.bold16White.copyWith(
                              color: AppColors.primary,
                            ),
                            removePrefix: true,
                            fillColor: Color(0xffF0ECFF),
                            isFilled: true,
                            dropSufffix: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: SvgPicture.asset(AppIcons.dropMenuIc),
                            ),
                            selectedValue: state.task.status ?? "",
                            onDropdownChanged: (String? newValue) {
                              print("Selected: $newValue");
                            },
                            items: ["InProgress", "Waiting", "Finished"],
                          ),
                          CustomDropdownTextField(
                            controller: TextEditingController(
                              text: state.task.priority ?? "",
                            ),
                            style: AppStyles.bold16White.copyWith(
                              color: AppColors.primary,
                            ),
                            labelText:
                                "${state.task.priority != null ? state.task.priority![0].toUpperCase() + state.task.priority!.substring(1).toLowerCase() : ""} Priority",
                            labelStyle: AppStyles.bold16White.copyWith(
                              color: AppColors.primary,
                            ),
                            removeSuffix: true,
                            prefix: SvgPicture.asset(AppIcons.flagIc),
                            fillColor: Color(0xffF0ECFF),
                            isFilled: true,
                            dropSufffix: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: SvgPicture.asset(AppIcons.dropMenuIc),
                            ),
                            items: [
                              "Low Priority",
                              "Medium Priority",
                              "High Priority",
                            ],
                          ),
                          // Image.asset(AppImages.qr),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TaskGetByIdLoading) {
              return CustomLoadingWidget();
            } else if (state is TaskGetByIdError) {
              return Center(child: Text(state.error.toString()));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
