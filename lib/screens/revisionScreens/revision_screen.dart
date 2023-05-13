import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({Key? key}) : super(key: key);

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  GetTopicModel? getTopicModel;
  List<GetTopicsList>? getTopicList;

  GetCategories? getCategories;
  GetCategories? getQuestionTopic;

  bool? isLoading;

  // List<Map<String, dynamic>> topicInfo = [
  //   {
  //     'text': 'Notes - English Medium',
  //     'screenName': RouteHelper.samplePaperPdf,
  //     'imageString': '1'
  //   },
  //   {
  //     'text': 'Notes - Hindi Medium',
  //     'screenName': RouteHelper.samplePaperPdf,
  //     'imageString': '2'
  //   },
  //   // {
  //   //   'text': 'Projects - MCQ file',
  //   //   'screenName': RouteHelper.samplePaperPdf,
  //   //   'imageString': '3'
  //   // },
  //   {
  //     'text': 'Test Series - Book',
  //     'screenName': RouteHelper.samplePaperPdf,
  //     'imageString': '4'
  //   },
  //   {
  //     'text': 'Sample paper',
  //     'screenName': RouteHelper.samplePaperPdf,
  //     'imageString': '5'
  //   },
  //   {
  //     'text': 'Videos',
  //     'screenName': RouteHelper.subjectVideos,
  //     'imageString': '6'
  //   },
  // ];

  List<DrawerModel> topics = [];

  // List<DrawerModel> topics = [
  //   // DrawerModel(
  //   //     text: 'Notes - English Medium',
  //   //     screenName: RouteHelper.samplePaperPdf,
  //   //     imageString: '1'),
  //   // DrawerModel(
  //   //     text: 'Notes - Hindi Medium ',
  //   //     screenName: RouteHelper.samplePaperPdf,
  //   //     imageString: '2'),
  //   // DrawerModel(
  //   //     text: 'Projects - MCQ file',
  //   //     screenName: RouteHelper.samplePaperPdf,
  //   //     imageString: '3'),
  //   // DrawerModel(
  //   //     text: 'Test Series - Book',
  //   //     screenName: RouteHelper.samplePaperPdf,
  //   //     imageString: '4'),
  //   // DrawerModel(
  //   //     text: 'Sample paper',
  //   //     screenName: RouteHelper.samplePaperPdf,
  //   //     imageString: '5'),
  //   // DrawerModel(
  //   //     text: 'MCQ Test',
  //   //     screenName: RouteHelper.questionAndAnswerTopics,
  //   //     imageString: '1'),
  //   // DrawerModel(text: 'Videos', screenName: RouteHelper.subjectVideos),
  // ];
  //
  // getList() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   // getTopicModel = await ApiServices()
  //   //     .getTopicsApi(subject_id: SharedPrefClass.getInt(AppStrings.topicId));
  //   //
  //   // for (int i = 0; i < 6; i++) {
  //   //   if (getTopicModel?.data?.any(
  //   //           (element) => element.type.toString().contains(i.toString())) ==
  //   //       true) {
  //   //     if (i == 1) {
  //   //       List<DrawerModel> topicsData = [
  //   //         DrawerModel(
  //   //             text: topicInfo[i]['text'],
  //   //             screenName: topicInfo[i]['screenName'],
  //   //             imageString: topicInfo[i]['imageString']),
  //   //         DrawerModel(
  //   //             text: 'MCQ Test',
  //   //             screenName: RouteHelper.questionAndAnswerTopics,
  //   //             imageString: '1'),
  //   //       ];
  //   //       topics.addAll(topicsData);
  //   //     } else {
  //   //       topics.add(
  //   //         DrawerModel(
  //   //             text: topicInfo[i]['text'],
  //   //             screenName: topicInfo[i]['screenName'],
  //   //             imageString: topicInfo[i]['imageString']),
  //   //       );
  //   //     }
  //   //   }
  //   // }
  //   //     .then((value) async {
  //   //   // log('value!.data ${value!.data}');
  //   //   // log('value!.data ${value.data}');
  //   //
  //   //   // log('value!.data ${value.data?.length}');
  //   //   // if (value.data?.length != 0) {
  //   //   //   topics.add(DrawerModel(
  //   //   //       text: 'Video',
  //   //   //       screenName: RouteHelper.subjectVideos,
  //   //   //       imageString: '6'));
  //   //   // }
  //   //   // getCategories = await ApiServices().getCategoriesApi();
  //   //   // print('Categoory ${getCategories}');
  //   //   // if (getCategories?.data.length != 0) {
  //   //   //   for (int i = 0; i < getCategories!.data.length; i++) {
  //   //   //     topics.add(DrawerModel(
  //   //   //         text: getCategories!.data[i].name,
  //   //   //         screenName: RouteHelper.samplePaperPdf,
  //   //   //         imageString: getCategories!.data[i].id.toString()));
  //   //   //   }
  //   //   // }
  //   // });
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('1')) ==
  //   //     true) {
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'Notes - English Medium',
  //   //         screenName: RouteHelper.samplePaperPdf,
  //   //         imageString: '1'),
  //   //   );
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'MCQ Test',
  //   //         screenName: RouteHelper.questionAndAnswerTopics,
  //   //         imageString: '1'),
  //   //   );
  //   // }
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('2')) ==
  //   //     true) {
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'Notes - Hindi Medium ',
  //   //         screenName: RouteHelper.samplePaperPdf,
  //   //         imageString: '2'),
  //   //   );
  //   // }
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('3')) ==
  //   //     true) {
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'Projects - MCQ file',
  //   //         screenName: RouteHelper.samplePaperPdf,
  //   //         imageString: '3'),
  //   //   );
  //   // }
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('4')) ==
  //   //     true) {
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'Test Series - Book',
  //   //         screenName: RouteHelper.samplePaperPdf,
  //   //         imageString: '4'),
  //   //   );
  //   // }
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('5')) ==
  //   //     true) {
  //   //   topics.add(
  //   //     DrawerModel(
  //   //         text: 'Sample paper',
  //   //         screenName: RouteHelper.samplePaperPdf,
  //   //         imageString: '5'),
  //   //   );
  //   // }
  //   // if (getTopicModel?.data
  //   //         ?.any((element) => element.type.toString().contains('6')) ==
  //   //     true) {
  //   //   topics.add(DrawerModel(
  //   //       text: 'Video',
  //   //       screenName: RouteHelper.subjectVideos,
  //   //       imageString: '6'));
  //   // }
  //
  //   // print(getTopicModel?.data
  //   //     ?.any((element) => element.type.toString().contains('2')));
  //   // print(getTopicModel?.data
  //   //     ?.any((element) => element.type.toString().contains('3')));
  //   // print(getTopicModel?.data
  //   //     ?.any((element) => element.type.toString().contains('4')));
  //   // print(getTopicModel?.data
  //   //     ?.any((element) => element.type.toString().contains('5')));
  //   // print(getTopicModel?.data
  //   //     ?.any((element) => element.type.toString().contains('6')));
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getAllDataBloc.add(OnPressedGetCategories());
    log('ID ${SharedPrefClass.getInt(AppStrings.topicId)}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      // drawer: AppWidgets.drawerWidget(),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppWidgets.smallHalfRect(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidgets.appBarWidget(
                        onTapOnBackButton: () => Get.back()),
                    // Get.offAllNamed(RouteHelper.subjectScreen)),
                    AppWidgets.userInfo(),
                  ],
                )),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  SharedPrefClass.getString(AppStrings.subjectName),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.extraLargeTextStyle().copyWith(
                      letterSpacing: 1,
                      color: AppColors.darkOrange,
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocConsumer<GetAllDataBloc, GetAllDataState>(
                  listener: ((context, state) async {
                    if (state is GetAllDataInitial) {
                      setState(() {
                        isLoading = state.loading;
                      });
                    } else if (state is GetCategoriesLoaded) {
                      getCategories = state.getCategories;
                      log(getCategories!.data!.length.toString());
                      getAllDataBloc.add(OnPressedGetTopicEvent(
                        subjectId: SharedPrefClass.getInt(AppStrings.topicId),
                      ));
                    } else if (state is GetQuestionsTopicsLoaded) {
                      getQuestionTopic = state.getQuestionsTOpics;
                      if (getQuestionTopic!.data!.isNotEmpty) {
                        topics.add(DrawerModel(
                            text: 'Projects - MCQ file',
                            screenName: RouteHelper.samplePaperPdf,
                            imageString: '0'));
                      }
                    } else if (state is GetTopicsLoaded) {
                      getTopicModel = state.getTopicModel;

                      addTopics(getTopicModel);
                      getAllDataBloc.add(OnPressedGetQuestionsTopics(
                          subjectId:
                              SharedPrefClass.getInt(AppStrings.topicId)));
                    }
                  }),
                  builder: ((context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: isLoading == true
                          ? AppWidgets.circularIndicator()
                          : topics.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('No Data Found',
                                        style: AppTextStyles.smallTextStyle()
                                            .copyWith(
                                                color: AppColors.darkGrey)),
                                  ],
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: topics.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 4.w,
                                          crossAxisSpacing: 4.w,
                                          childAspectRatio: 3),
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        // Get.toNamed(topics[index].screenName.toString(),
                                        //     arguments: [topics[index].text, index + 1])
                                        if (topics[index].imageString == '0') {
                                          Get.toNamed(
                                              RouteHelper
                                                  .questionAndAnswerTopics,
                                              arguments: [
                                                topics[index].text,
                                                getQuestionTopic
                                              ]);
                                        } else {
                                          log('${getTopicModel?.data?.where((element) => element.type == int.parse(topics[index].imageString.toString())).toList()}');
                                          getTopicList = getTopicModel?.data
                                              ?.where((element) =>
                                                  element.type ==
                                                  int.parse(topics[index]
                                                      .imageString
                                                      .toString()))
                                              .toList();
                                          log('Lenght ${getTopicList?.length}');
                                          Get.toNamed(
                                              topics[index]
                                                  .screenName
                                                  .toString(),
                                              arguments: [
                                                topics[index].text,
                                                getTopicList
                                              ]);

                                          // Get.toNamed(
                                          //     topics[index]
                                          //         .screenName
                                          //         .toString(),
                                          //     arguments: [
                                          //       topics[index].text,
                                          //       int.parse(topics[index]
                                          //           .imageString
                                          //           .toString())
                                          //     ]
                                          // )
                                        }
                                      },
                                      child: Container(
                                        height: 2.h,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.w),
                                            gradient: LinearGradient(
                                                colors: index % 6 == 0
                                                    ? AppUtils.colorsList[0]
                                                    : index % 6 == 1
                                                        ? AppUtils.colorsList[1]
                                                        : index % 6 == 2
                                                            ? AppUtils
                                                                .colorsList[2]
                                                            : index % 6 == 3
                                                                ? AppUtils
                                                                        .colorsList[
                                                                    3]
                                                                : index % 6 == 4
                                                                    ? AppUtils
                                                                            .colorsList[
                                                                        4]
                                                                    : AppUtils
                                                                            .colorsList[
                                                                        5])),
                                        child: Text(
                                          topics[index].text,
                                          style: AppTextStyles.smallTextStyle(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  })),
                    );
                  }),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          )),
    ));
  }

  GetTopicModel? addTopics(GetTopicModel? getTopicModel) {
    topics = [];

    for (int i = 0; i < getCategories!.data!.length; i++) {
      log('TYPE ${i + 1}');
      log('nameTY ${getCategories?.data?[i].name}');
      log('${getTopicModel?.data?.any((element) => element.type == getCategories?.data?[i].id)}');
      if (getTopicModel?.data
              ?.any((element) => element.type == getCategories?.data?[i].id) ==
          true) {
        log('name ${getCategories?.data?[i].name}');
        topics.add(DrawerModel(
            text: getCategories?.data?[i].name ?? ' ',
            screenName: getCategories?.data?[i].id == 6
                ? RouteHelper.subjectVideo
                : RouteHelper.samplePaperPdf,
            imageString: getCategories?.data?[i].id.toString()));
      }
    }
    setState(() {});
    return getTopicModel;
  }
}
