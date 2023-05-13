import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class ViewSolutions extends StatefulWidget {
  const ViewSolutions({Key? key}) : super(key: key);

  @override
  State<ViewSolutions> createState() => _ViewSolutionsState();
}

class _ViewSolutionsState extends State<ViewSolutions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: AppWidgets.textButton(
          width: 30.w, onTap: () => Get.back(), text: 'Back'),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              AppWidgets.fullRect(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidgets.appBarWidget(),
                  SizedBox(
                    height: 1.h,
                  ),
                  AppWidgets.appBarWidgetForRevision(
                    subjectName: AppStrings.questionAndAnswer,
                    topicName:
                        SharedPrefClass.getString(AppStrings.innerTopicName),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      'Solution',
                      style: AppTextStyles.largeTextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkOrange,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                              backgroundColor: AppColors.boxColor2,
                              child: Text(
                                (Get.arguments[0] + 1).toString(),
                                style: AppTextStyles.smallTextStyle(),
                              )),
                        )),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Get.arguments[1].toString(),
                                textAlign: TextAlign.left,
                                style: AppTextStyles.smallTextStyle().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text(
                        Get.arguments[2].toString(),
                        style: AppTextStyles.mediumTextStyle()
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    ));
  }
}
