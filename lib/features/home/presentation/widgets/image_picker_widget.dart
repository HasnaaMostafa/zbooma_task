import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(PlatformFile) onImagePicked;
  final String? initialImagePath;

  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.initialImagePath,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? imagePath;
  
  @override
  void initState() {
    super.initState();
    imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        _handleImagePick(result.files.first);
      }
    } catch (e) {
      showToast(message: "Error picking image: $e", state: ToastStates.error);
    }
  }

  void _handleImagePick(PlatformFile image) {
    setState(() {
      imagePath = image.path;
    });
    widget.onImagePicked(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        color: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: imagePath == null || imagePath!.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.uploadImgIc),
                  SizedBox(width: 5.w),
                  Text(
                    "Add Img",
                    style: AppStyles.medium19Primary,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Img Uploaded",
                    style: AppStyles.medium14Black.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.check,
                    color: AppColors.primary,
                    size: 15,
                  ),
                ],
              ),
      ),
    );
  }
}