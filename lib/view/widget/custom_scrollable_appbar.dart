import 'package:dr_ai/core/helper/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomScrollableAppBar extends StatelessWidget {
  const CustomScrollableAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(8.w),
        IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        Text(
          title,
          style: context.textTheme.bodyLarge
              ?.copyWith(fontSize: 20.spMin, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}