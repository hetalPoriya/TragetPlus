import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';

class QuestionAndAnswerTopics extends StatefulWidget {
  const QuestionAndAnswerTopics({Key? key}) : super(key: key);

  @override
  State<QuestionAndAnswerTopics> createState() =>
      _QuestionAndAnswerTopicsState();
}

class _QuestionAndAnswerTopicsState extends State<QuestionAndAnswerTopics> {
  GetCategories? getQuestionTopic;
  @override
  void initState() {
    getQuestionTopic = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidgets.fullRect(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidgets.appBarWidget(
                            onTapOnBackButton: () => Get.back()),
                        // Get.offAllNamed(RouteHelper.revisionScreen)),
                        SizedBox(
                          height: 1.h,
                        ),
                        AppWidgets.appBarWidgetForRevision(
                            subjectName: SharedPrefClass.getString(
                              AppStrings.subjectName,
                            ),
                            topicName: AppStrings.questionAndAnswer),
                      ],
                    )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      child: Text(
                        'Topics',
                        style: AppTextStyles.largeTextStyle().copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkOrange,
                            decoration: TextDecoration.underline,
                            letterSpacing: 1,
                            decorationThickness: 2),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    (getQuestionTopic!.data!.isEmpty ||
                            getQuestionTopic!.data == [])
                        ? Container(
                            height: 70.h,
                            alignment: Alignment.center,
                            child: Text(
                              'No Data Found',
                              style: AppTextStyles.smallTextStyle()
                                  .copyWith(color: Colors.black),
                            ))
                        : ListView.builder(
                            itemCount: getQuestionTopic!.data?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6.h,
                                      child: Row(children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            getQuestionTopic!
                                                    .data?[index].name ??
                                                ' ',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppTextStyles.smallTextStyle()
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                            child: GestureDetector(
                                          onTap: () {
                                            SharedPrefClass.setInt(
                                                AppStrings.innerTopicId,
                                                getQuestionTopic!
                                                    .data![index].id!);
                                            SharedPrefClass.setString(
                                                AppStrings.innerTopicName,
                                                getQuestionTopic!
                                                    .data![index].name!);
                                            Get.toNamed(
                                                RouteHelper.questionsAndAnswer,
                                                arguments: [
                                                  getQuestionTopic!
                                                      .data?[index].id,
                                                  getQuestionTopic!
                                                      .data?[index].name,
                                                ]);
                                          },
                                          child: Container(
                                              height: 5.h,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.w),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.boxColor1,
                                                        AppColors.boxColor2
                                                      ])),
                                              child: Text(AppStrings.startTest,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .smallTextStyle())),
                                        )),
                                      ]),
                                    ),
                                    SizedBox(height: 1.h),
                                    Divider(color: AppColors.darkGrey),
                                    SizedBox(
                                      height: 1.h,
                                    )
                                  ],
                                ),
                              );
                            }))
                  ],
                ))));
  }
}
