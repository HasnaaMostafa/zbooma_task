import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart'; // Added for camera support
import 'package:zbooma_task/core/static/app_styles.dart';
import 'package:zbooma_task/core/static/icons.dart';
import 'package:zbooma_task/core/theme/colors.dart';
import 'package:zbooma_task/core/utils/widgets/dialogs/flutter_toast.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(PlatformFile) onImagePicked;
  final String? initialImagePath;
  final bool isImageValidated;

  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.initialImagePath,
    required this.isImageValidated,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? imagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imagePath = widget.initialImagePath;
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.primary),
                title: Text('Take a photo', style: AppStyles.medium14Black),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.primary),
                title: Text(
                  'Choose from gallery',
                  style: AppStyles.medium14Black,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        final file = File(photo.path);
        final PlatformFile platformFile = PlatformFile(
          path: photo.path,
          name: photo.name,
          size: await file.length(),
          bytes: await file.readAsBytes(),
        );
        _handleImagePick(platformFile);
      }
    } catch (e) {
      print(e.toString());
      showToast(message: "Error capturing image: $e", state: ToastStates.error);
    }
  }

  Future<void> _pickImageFromGallery() async {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showImageSourceOptions,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12.r),
            color:
                !widget.isImageValidated
                    ? Colors.red.shade900
                    : AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child:
                imagePath == null || imagePath!.isEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.uploadImgIc,
                          colorFilter: ColorFilter.mode(
                            !widget.isImageValidated
                                ? Colors.red.shade900
                                : AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Add Image",
                          style: AppStyles.medium19Primary.copyWith(
                            color:
                                !widget.isImageValidated
                                    ? Colors.red.shade900
                                    : AppColors.primary,
                          ),
                        ),
                      ],
                    )
                    : Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            File(imagePath!),
                            height: 100.h,
                            width: 150.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Image Uploaded",
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
                      ],
                    ),
          ),
        ),
        if (!widget.isImageValidated)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 12.w),
            child: Text(
              "Image Required",
              style: TextStyle(color: Colors.red.shade900, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}
