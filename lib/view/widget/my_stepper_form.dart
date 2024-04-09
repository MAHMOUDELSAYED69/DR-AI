// ignore_for_file: deprecated_member_use

import 'package:dr_ai/core/constant/color.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyStepperForm extends StatefulWidget {
  const MyStepperForm({super.key, required this.stepReachedNumber});
  final int stepReachedNumber;
  @override
  MyStepperFormState createState() => MyStepperFormState();
}

class MyStepperFormState extends State<MyStepperForm> {
  int activeStep = 0;
  @override
  void initState() {
    activeStep = widget.stepReachedNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      padding: EdgeInsets.zero,
      enableStepTapping: false,
      activeStep: activeStep,
      lineStyle: LineStyle(
        lineLength: context.width / 6,
        lineType: LineType.dashed,
        activeLineColor: ColorManager.green,
        finishedLineColor: ColorManager.green,
        defaultLineColor: ColorManager.grey,
        lineThickness: 2.dm,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 6.dm,
      borderThickness: 3.dm,
      activeStepBorderColor: ColorManager.green,
      defaultStepBorderType: BorderType.normal,
      stepRadius: 24.r,
      finishedStepBorderColor: ColorManager.green,
      finishedStepTextColor: Colors.deepOrange,
      finishedStepBackgroundColor: ColorManager.white,
      activeStepIconColor: ColorManager.white,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.emailIcon,
            color: activeStep >= 0 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Email",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 0 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.passwordIcon,
            color: activeStep >= 1 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Password",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 1 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
        EasyStep(
          customStep: SvgPicture.asset(
            width: 18.w,
            height: 18.w,
            ImageManager.userIcon,
            color: activeStep >= 2 ? ColorManager.green : ColorManager.grey,
          ),
          customTitle: Text(
            "Information",
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: activeStep >= 2 ? ColorManager.black : ColorManager.grey,
            ),
          ),
        ),
      ],
      // onStepReached: (_) =>
      //     setState(() => activeStep = widget.stepReachedNumber),
    );
  }
}
