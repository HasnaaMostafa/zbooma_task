import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zbooma_task/core/services/di.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/appbar/custom_appbar.dart';
import 'package:zbooma_task/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_date_textfield.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/custom_text_text_field.dart';
import 'package:zbooma_task/core/utils/widgets/inputs/drop_menu_text_field.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_cubit.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_state.dart';
import 'package:zbooma_task/features/home/presentation/widgets/image_picker_widget.dart';

class AddNewTaskView extends StatefulWidget {
  const AddNewTaskView({super.key});

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController titleContoller = TextEditingController();
  TextEditingController descContoller = TextEditingController();
  TextEditingController datecContoller = TextEditingController();

  String? priority;
  String imagePath = "";
  bool isImageValidated = true;

  @override
  void dispose() {
    titleContoller.dispose();
    descContoller.dispose();
    super.dispose();
  }

  void _onImagePicked(PlatformFile image) {
    setState(() {
      imagePath = image.path ?? "";
      isImageValidated = true;
      print(imagePath);
    });
  }

  bool validateImage() {
    if (imagePath.isEmpty) {
      setState(() {
        isImageValidated = false;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add new task"),
      body: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ImagePickerWidget(
                  isImageValidated: isImageValidated,
                  onImagePicked: _onImagePicked,
                  initialImagePath: imagePath,
                ),
                SizedBox(height: 16.h),
                CustomTextTextField(
                  text: "Task title",
                  hintText: "Enter title here...",
                  removeSuffix: true,
                  removePrefix: true,
                  controller: titleContoller,
                ),
                CustomTextTextField(
                  text: "Task Description",
                  hintText: "Enter description here...",
                  maxLine: 6,
                  removeSuffix: true,
                  removePrefix: true,
                  controller: descContoller,
                ),
                CustomDropdownTextField(
                  text: "Priority",
                  style: AppStyles.bold16White.copyWith(
                    color: AppColors.primary,
                  ),
                  onDropdownChanged: (value) {
                    final String firstWord = value!.split(' ')[0].toLowerCase();
                    setState(() {
                      priority = firstWord;
                    });
                    print("Selected Priority: $firstWord");
                  },
                  selectedValue: priority,
                  removeSuffix: true,
                  prefix: SvgPicture.asset(AppIcons.flagIc),
                  fillColor: Color(0xffF0ECFF),
                  isFilled: true,
                  dropSufffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(AppIcons.dropMenuIc),
                  ),
                  items: ["Low Priority", "Medium Priority", "High Priority"],
                ),
                CustomDateTextField(
                  text: "Due date",
                  dateController: datecContoller,
                  hint: "choose due date...",
                ),
                SizedBox(height: 8.h),
                BlocProvider(
                  create: (context) => TaskCubit(sl()),
                  child: BlocConsumer<TaskCubit, TaskState>(
                    listener: (context, state) {
                      if (state is TaskCreateSuccess) {
                        showToast(
                          message: "Created Successfully",
                          state: ToastStates.success,
                        );
                        Navigator.pop(context);
                      }
                      if (state is TaskCreateError) {
                        showToast(
                          message: state.error,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                        isLoading: state is TaskCreateLoading,
                        title: "Add task",
                        onPressed: () {
                          bool isImageValid = validateImage();
                          if (formKey.currentState!.validate() &&
                              isImageValid) {
                            context.read<TaskCubit>().createTask(
                              title: titleContoller.text,
                              desc: descContoller.text,
                              priority: priority ?? "",
                              image: imagePath,
                              endDate: getDate(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDate() {
    final DateFormat inputFormatter = DateFormat('d MMMM, y');

    final DateTime dateTime = inputFormatter.parse(datecContoller.text);

    final DateFormat outputFormatter = DateFormat('yyyy-MM-dd');
    String date = outputFormatter.format(dateTime);
    return date;
  }
}
