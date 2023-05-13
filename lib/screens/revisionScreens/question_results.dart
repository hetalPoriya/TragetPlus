import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';

class QuestionsResults extends StatefulWidget {
  const QuestionsResults({Key? key}) : super(key: key);

  @override
  State<QuestionsResults> createState() => _QuestionsResultsState();
}

class _QuestionsResultsState extends State<QuestionsResults> {
  bool? loading;
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  List<GetQuestionResultList>? getQuestionResultList = [];
  PageController pageController = PageController();
  int pageViewIndexCount = 0;
  bool? checked;
  String? topicName;
  int? howManyPage = 0;
  int? listviewLength = 3;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    topicName = SharedPrefClass.getString(AppStrings.innerTopicName);

    getAllDataBloc.add(OnPressedGetQuestionsResultsEvent(
        topicId: SharedPrefClass.getInt(AppStrings.innerTopicId),
        studentId: SharedPrefClass.getInt(AppStrings.id)));
    // getAllDataBloc.add(onPressedGetQuestionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: loading == true
          ? Container()
          : Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.h),
                  child: AppWidgets.textButton(
                      width: 30.w,
                      onTap: () {
                        if ((pageViewIndexCount + 1) == howManyPage) {
                          Get.offNamedUntil(
                              RouteHelper.subjectScreen, (route) => false);
                          // String data = json.decode(margeModel.toString());

                          //     'margeModel ${margeModel.asMap().entries.map((e) => {})}');
                          // SharedPrefClass.setMargeModelData();

                          // String? login = await SharedPrefClass.getMargeModelData();
                          // MargeModel data = margeModelFromMap(login);
                        }
                        if (howManyPage == pageViewIndexCount + 2) {
                          if ((howManyPage! * 3) !=
                              getQuestionResultList?.length) {
                            if (((howManyPage! * 3) - 1) ==
                                getQuestionResultList?.length) {
                              setState(() {
                                listviewLength = 2;
                              });
                            } else {
                              setState(() {
                                listviewLength = 1;
                              });
                            }
                          } else {
                            listviewLength = 3;
                          }
                        }
                        pageController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.linearToEaseOut);
                      },
                      text: (pageViewIndexCount + 1) == howManyPage
                          ? 'Submit'
                          : 'Next'),
                ),
              ),
            ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocConsumer<GetAllDataBloc, GetAllDataState>(
            listener: ((context, state) {
              if (state is GetAllDataInitial) {
                setState(() {
                  loading = state.loading;
                });
              } else if (state is GetQuestionsResultLoaded) {
                setState(() {
                  getQuestionResultList = state.getQuestionResultModel?.data;
                  howManyPage = ((getQuestionResultList?.length)! / 3).ceil();
                });
              }
            }),
            builder: ((context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidgets.fullRect(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets.appBarWidget(
                          onTapOnBackButton: () => Get.offNamedUntil(
                              RouteHelper.revisionScreen, (route) => false)),
                      SizedBox(
                        height: 1.h,
                      ),
                      AppWidgets.appBarWidgetForRevision(
                          subjectName: AppStrings.questionAndAnswer,
                          topicName: topicName ?? ''),
                    ],
                  )),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  loading == true
                      ? AppWidgets.circularIndicator()
                      : getQuestionResultList!.isNotEmpty
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Text(
                                      'Your Results',
                                      style: AppTextStyles.largeTextStyle()
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.darkOrange,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 2),
                                    ),
                                  ),
                                  Expanded(
                                    child: PageView.builder(
                                        controller: pageController,
                                        itemCount: howManyPage,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: ((context, pageViewIndex) {
                                          pageViewIndexCount = pageViewIndex;
                                          return ListView.builder(
                                              padding: EdgeInsets.only(
                                                  right: 6.w,
                                                  left: 6.w,
                                                  bottom: 6.h,
                                                  top: 3.h),
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: getQuestionResultList!
                                                          .length >=
                                                      3
                                                  ? listviewLength
                                                  : getQuestionResultList!
                                                      .length,
                                              itemBuilder:
                                                  ((context, innerIndex) {
                                                var response =
                                                    getQuestionResultList![
                                                        ((pageViewIndex * 3) +
                                                            innerIndex)];

                                                var studentAnswer =
                                                    response.studentAnswer;
                                                return Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .boxColor2,
                                                            child: Text(
                                                              ((pageViewIndex *
                                                                          3) +
                                                                      (innerIndex +
                                                                          1))
                                                                  .toString(),
                                                              style: AppTextStyles
                                                                  .smallTextStyle(),
                                                            )),
                                                      )),
                                                      Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  response.question ??
                                                                      '',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppTextStyles.smallTextStyle().copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                multiCheckBox(
                                                                  text: response
                                                                      .option1,
                                                                  checked: studentAnswer ==
                                                                          'option_1'
                                                                      ? true
                                                                      : false,
                                                                ),
                                                                multiCheckBox(
                                                                  text: response
                                                                      .option2,
                                                                  checked: studentAnswer ==
                                                                          'option_2'
                                                                      ? true
                                                                      : false,
                                                                ),
                                                                multiCheckBox(
                                                                  text: response
                                                                      .option3,
                                                                  checked: studentAnswer ==
                                                                          'option_3'
                                                                      ? true
                                                                      : false,
                                                                ),
                                                                multiCheckBox(
                                                                  text: response
                                                                      .option4,
                                                                  checked: studentAnswer ==
                                                                          'option_4'
                                                                      ? true
                                                                      : false,
                                                                ),
                                                              ])),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        AppStrings
                                                            .correctAnswer,
                                                        style: AppTextStyles
                                                                .extraSmallTextStyle()
                                                            .copyWith(
                                                                fontSize: 8.sp,
                                                                color: AppColors
                                                                    .lightBlue),
                                                      ),
                                                      Text(
                                                        response.answer
                                                            .toString(),
                                                        style: AppTextStyles
                                                                .extraSmallTextStyle()
                                                            .copyWith(
                                                                fontSize: 8.sp,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => Get.toNamed(
                                                            RouteHelper
                                                                .viewSolutions,
                                                            arguments: [
                                                              ((pageViewIndex *
                                                                      3) +
                                                                  innerIndex),
                                                              response.question,
                                                              response.solution,
                                                            ]),
                                                        child: Text(
                                                          AppStrings
                                                              .viewSolution,
                                                          style: AppTextStyles
                                                                  .extraSmallTextStyle()
                                                              .copyWith(
                                                                  fontSize:
                                                                      8.sp,
                                                                  color: AppColors
                                                                      .lightBlue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                      color:
                                                          AppColors.lightGrey,
                                                      thickness: 1),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                ]);
                                              }));
                                        })),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  'No Data Found',
                                  style: AppTextStyles.smallTextStyle()
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                ],
              );
            }),
          )),
    ));
  }

  Widget multiCheckBox(
      {String? text, bool? checked, void Function(bool?)? onChanged}) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: checked,
            visualDensity: VisualDensity.compact,
            onChanged: onChanged,
          ), // you can control gap between checkbox and label with this field
          Flexible(
            child: Text(text.toString(),
                style: AppTextStyles.smallTextStyle()
                    .copyWith(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
