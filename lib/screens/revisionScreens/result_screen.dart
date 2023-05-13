import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import '../../utils/utils.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      AppWidgets.bigHalfRect(),
                      OrientationBuilder(builder: ((context, orientation) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppWidgets.appBarWidget(
                                onTapOnBackButton: () => Get.offNamedUntil(
                                    RouteHelper.revisionScreen,
                                    (route) => false)),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                AppStrings.results,
                                style: AppTextStyles.mediumTextStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Material(
                                borderRadius: BorderRadius.circular(6.w),
                                elevation: 4,
                                child: Container(
                                  height: 60.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.w)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Congrats',
                                              style: AppTextStyles.boldStyle()
                                                  .copyWith(
                                                      color:
                                                          AppColors.lightGreen,
                                                      fontSize: 24.sp),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                'on completion of this test!',
                                                style: AppTextStyles
                                                        .mediumTextStyle()
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              AppWidgets.rowForResult(
                                                  text: AppStrings.totalQue,
                                                  marks: Get.arguments[0]
                                                          ['totalQuestion']
                                                      .toString()),
                                              SizedBox(
                                                height: 1.w,
                                              ),
                                              AppWidgets.rowForResult(
                                                  text: AppStrings
                                                      .attemptQuestion,
                                                  marks: Get.arguments[1]
                                                          ['attemptAnswer']
                                                      .toString()),
                                              SizedBox(
                                                height: 1.w,
                                              ),
                                              AppWidgets.rowForResult(
                                                  text: AppStrings.rightAnswer,
                                                  marks: Get.arguments[2]
                                                          ['correctAnswer']
                                                      .toString()),
                                              SizedBox(
                                                height: 1.w,
                                              ),
                                              AppWidgets.rowForResult(
                                                  text: AppStrings.wrongAns,
                                                  marks: Get.arguments[3]
                                                          ['wrongAnswer']
                                                      .toString()),
                                              SizedBox(
                                                height: 1.w,
                                              ),
                                              AppWidgets.rowForResult(
                                                  text: AppStrings.notAttempt,
                                                  marks: Get.arguments[4]
                                                          ['notAttempt']
                                                      .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            '${AppStrings.totalScore}${Get.arguments[2]['correctAnswer'].toString()}',
                                            style:
                                                AppTextStyles.smallTextStyle()
                                                    .copyWith(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Divider(
                                            color: AppColors.lightGrey,
                                            thickness: 1,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          AppWidgets.textButton(
                                              text: 'View Questions',
                                              onTap: () => Get.offAndToNamed(
                                                  RouteHelper.questionsResults),
                                              width: 50.w)
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            )
                          ],
                        );
                      }))
                    ],
                  ),
                ))));
  }
}
