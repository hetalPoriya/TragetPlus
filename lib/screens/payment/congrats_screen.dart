import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: AppWidgets.appBarWithImage(
        appBarWidget: AppWidgets.appBarWidget(
            onTapOnBackButton: () =>
                Get.offNamedUntil(RouteHelper.subjectScreen, (route) => false)),
        middleCardWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Material(
            borderRadius: BorderRadius.circular(6.w),
            elevation: 4,
            child: Container(
              height: 60.h,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'Congrats!',
                          style: AppTextStyles.boldStyle().copyWith(
                              color: AppColors.darkGreen, fontSize: 26.sp),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'You have Successfully withdraw the amount it will reflect in 5-7 workings days',
                        style: AppTextStyles.largeTextStyle()
                            .copyWith(color: AppColors.darkGrey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Divider(thickness: 2),
                      SizedBox(height: 2.h),
                    ]),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
