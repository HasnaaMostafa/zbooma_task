import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zbooma_task/features/home/presentation/cubit/task_cubit.dart';
import 'package:zbooma_task/features/home/presentation/widgets/category_item.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  static const List<String> titles = ["All", "Low", "Medium", "High"];

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SizedBox(
        height: 40.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: CategoryListView.titles.length,
          separatorBuilder: (context, index) => SizedBox(width: 8),
          itemBuilder: (context, index) {
            return CategoryItem(
              title: CategoryListView.titles[index],
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                context.read<TaskCubit>().filterTasksByPriority(
                  CategoryListView.titles[index].toLowerCase(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
