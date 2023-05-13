import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            body: AppWidgets.appBarWithImage(
              middleCardWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Material(
                  borderRadius: BorderRadius.circular(6.w),
                  elevation: 4,
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          SizedBox(
                              width: 40.w,
                              //color: Colors.green,
                              child: Image.asset(
                                AppImages.paymentSuccessful,
                              )),
                          SizedBox(
                            height: 4.h,
                          ),
                          Flexible(
                              child: Text(AppStrings.paymentSuccessfulText,
                                  style: AppTextStyles.mediumTextStyle()
                                      .copyWith(color: AppColors.lightGrey))),
                          SizedBox(
                            height: 2.h,
                          ),
                          Flexible(
                              child: Text(AppStrings.thankYouForPaying,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.mediumTextStyle()
                                      .copyWith(color: AppColors.darkGrey))),
                          SizedBox(
                            height: 8.h,
                          ),
                          Flexible(
                              child: GestureDetector(
                            onTap: () => Get.toNamed(RouteHelper.inviteAndEarn),
                            child: Container(
                              width: 48.w,
                              height: 5.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.w),
                                  gradient: LinearGradient(colors: [
                                    AppColors.darkOrange,
                                    AppColors.lightOrange,
                                  ])),
                              child: Text(AppStrings.inviteAndEarn,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.smallTextStyle()),
                            ),
                          )),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () => Get.offNamedUntil(
                                RouteHelper.mainScreen, (route) => false),
                            // onTap: () => Get.offNamedUntil(
                            //     RouteHelper.subjectScreen, (route) => false),
                            child: Text(AppStrings.letsStart,
                                style: AppTextStyles.smallTextStyle()
                                    .copyWith(color: AppColors.darkGrey)),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
