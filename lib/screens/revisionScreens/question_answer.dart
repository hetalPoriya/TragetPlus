import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';

class QuestionsAndAnswer extends StatefulWidget {
  const QuestionsAndAnswer({Key? key}) : super(key: key);

  @override
  State<QuestionsAndAnswer> createState() => _QuestionsAndAnswerState();
}

class _QuestionsAndAnswerState extends State<QuestionsAndAnswer> {
  bool? loading;
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  List<GetQuestionList>? getQuestionsList = [];

  // List<MargeModel> margeModel = [];
  PageController pageController = PageController();
  int pageViewIndexCount = 0;
  bool? checked;
  String? topicName;
  int? howManyPage = 0;
  int? listviewLength = 3;
  int attemptAnswer = 0;
  int notAttempt = 0;
  int correctAnswer = 0;
  int wrongAnswer = 0;

  @override
  void initState() {
    topicName = SharedPrefClass.getString(AppStrings.innerTopicName);
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getAllDataBloc.add(OnPressedGetQuestionsEvent(
        topicId: SharedPrefClass.getInt(AppStrings.innerTopicId)));
    // getAllDataBloc.add(onPressedGetQuestionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: AppWidgets.textButton(
          width: 30.w,
          onTap: () {
            if ((pageViewIndexCount + 1) == howManyPage) {
              attemptAnswer = 0;
              notAttempt = 0;
              correctAnswer = 0;
              wrongAnswer = 0;
              for (int i = 0; i < getQuestionsList!.length; i++) {
                if (getQuestionsList?[i].answer ==
                    getQuestionsList?[i].answerString) {
                  correctAnswer = correctAnswer + 1;
                }
                if (getQuestionsList?[i].answerString.toString() != '') {
                  setState(() {
                    attemptAnswer = attemptAnswer + 1;
                  });
                }
              }
              notAttempt = getQuestionsList!.length - attemptAnswer;
              wrongAnswer = attemptAnswer - correctAnswer;

              Get.toNamed(RouteHelper.resultScreen, arguments: [
                {"totalQuestion": getQuestionsList!.length},
                {"attemptAnswer": attemptAnswer},
                {"correctAnswer": correctAnswer},
                {"wrongAnswer": wrongAnswer},
                {"notAttempt": notAttempt},
              ]);
              // String data = json.decode(margeModel.toString());
              // print('Data ${data}');
              // print('margeModel ${margeModel.length}');
              // print('margeModel ${margeModel.toString()}');
              // print(
              //     'margeModel ${margeModel.asMap().entries.map((e) => {})}');
              // SharedPrefClass.setMargeModelData();

              // print('marge Mopdel ${margeModel}');
              // String? login = await SharedPrefClass.getMargeModelData();
              // MargeModel data = margeModelFromMap(login);
              // print(data.data?.answer);
            }
            if (howManyPage == pageViewIndexCount + 2) {
              if ((howManyPage! * 3) != getQuestionsList?.length) {
                if (((howManyPage! * 3) - 1) == getQuestionsList?.length) {
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
          text: (pageViewIndexCount + 1) == howManyPage ? 'Submit' : 'Next'),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocConsumer<GetAllDataBloc, GetAllDataState>(
            listener: ((context, state) {
              if (state is GetAllDataInitial) {
                setState(() {
                  loading = state.loading;
                });
              } else if (state is GetQuestionsLoaded) {
                setState(() {
                  getQuestionsList = state.getQuestionModel?.data;
                  howManyPage = ((getQuestionsList?.length)! / 3).ceil();
                  //   for (int i = 0; i < getQuestionsList!.length; i++) {
                  //     margeModel.add(MargeModel(
                  //         data: getQuestionsList?[i],
                  //         optionsModel: OptionsModel(options: [
                  //           getQuestionsList?[i].option1 ?? ' ',
                  //           getQuestionsList?[i].option2 ?? '',
                  //           getQuestionsList?[i].option3 ?? '',
                  //           getQuestionsList?[i].option4 ?? ''
                  //         ], optionsStatus: [
                  //           false,
                  //           false,
                  //           false,
                  //           false
                  //         ])));
                  //     setState(() {});
                  //   }
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
                          onTapOnBackButton: () => Get.back()),
                      // onTapOnBackButton: () => Get.offNamed(
                      //                 RouteHelper.questionAndAnswerTopics)),
                      SizedBox(
                        height: 1.h,
                      ),
                      AppWidgets.appBarWidgetForRevision(
                          subjectName: SharedPrefClass.getString(
                            AppStrings.subjectName,
                          ),
                          topicName: topicName ?? ''),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.w),
                      //   child: Text(
                      //     topicName ?? '',
                      //     style: AppTextStyles.extraSmallTextStyle(),
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                    ],
                  )),
                  loading == true
                      ? AppWidgets.circularIndicator()
                      : getQuestionsList!.isNotEmpty
                          ? Expanded(
                              child: PageView.builder(
                                  controller: pageController,
                                  itemCount: howManyPage,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: ((context, pageViewIndex) {
                                    pageViewIndexCount = pageViewIndex;
                                    return ListView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w, vertical: 2.h),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      children: [
                                        Text(
                                          (howManyPage == pageViewIndex + 1)
                                              ? 'Question ${getQuestionsList!.length} of ${getQuestionsList?.length}'
                                              : 'Question ${getQuestionsList!.length >= 3 ? (pageViewIndex + 1) * 3 : getQuestionsList!.length} of ${getQuestionsList?.length}',
                                          style: AppTextStyles.largeTextStyle()
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkOrange,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                getQuestionsList!.length >= 3
                                                    ? listviewLength
                                                    : getQuestionsList!.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder:
                                                ((context, innerIndex) {
                                              var response = getQuestionsList![
                                                  ((pageViewIndex * 3) +
                                                      innerIndex)];

                                              return Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                onChanged: (value) =>
                                                                    _studentAnswer(
                                                                        text:
                                                                            'option_1',
                                                                        response:
                                                                            response),
                                                                checked: response
                                                                            .answerString ==
                                                                        'option_1'
                                                                    ? true
                                                                    : false,
                                                              ),
                                                              multiCheckBox(
                                                                text: response
                                                                    .option2,
                                                                onChanged: (value) =>
                                                                    _studentAnswer(
                                                                        text:
                                                                            'option_2',
                                                                        response:
                                                                            response),
                                                                checked: response
                                                                            .answerString ==
                                                                        'option_2'
                                                                    ? true
                                                                    : false,
                                                              ),
                                                              multiCheckBox(
                                                                text: response
                                                                    .option3,
                                                                onChanged: (value) =>
                                                                    _studentAnswer(
                                                                        text:
                                                                            'option_3',
                                                                        response:
                                                                            response),
                                                                checked: response
                                                                            .answerString ==
                                                                        'option_3'
                                                                    ? true
                                                                    : false,
                                                              ),
                                                              multiCheckBox(
                                                                text: response
                                                                    .option4,
                                                                onChanged: (value) =>
                                                                    _studentAnswer(
                                                                        text:
                                                                            'option_4',
                                                                        response:
                                                                            response),
                                                                checked: response
                                                                            .answerString ==
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
                                                Divider(
                                                    color: AppColors.lightGrey,
                                                    thickness: 1),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                              ]);
                                            }))
                                      ],
                                    );
                                  })),
                            )
                          : Expanded(
                              child: Center(
                                child: Text(
                                  'No Data Found',
                                  style: AppTextStyles.smallTextStyle()
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            )
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
            activeColor: AppColors.darkOrange,
            checkColor: Colors.white,
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

  _studentAnswer({required String text, required GetQuestionList response}) {
    if (response.answerString.toString() == '') {
      ApiServices().saveAnswerApi(
          studentAnswer: text,
          studentId: SharedPrefClass.getInt(AppStrings.id),
          questionId: response.id);
    } else {
      ApiServices().updateAnswerApi(
          studentAnswer: text,
          studentId: SharedPrefClass.getInt(AppStrings.id),
          questionId: response.id);
    }
    setState(() {
      response.answerString = text;
    });
  }
}
