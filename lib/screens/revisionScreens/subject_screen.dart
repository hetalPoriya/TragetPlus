import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:traget_plus/screens/screens.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  bool loading = true;
  TextEditingController classCon = TextEditingController();
  TextEditingController streamCon = TextEditingController();
  List<GetSubjectList>? getSubjectList;
  GetClassesModel? getClassesModel;
  GetStreamsModel? getStreamsModel;
  int? classId;
  int? streamId;

  getClassesList() async {
    setState(() {
      classCon.text = SharedPrefClass.getString(AppStrings.selectClass);
      classId = SharedPrefClass.getInt(AppStrings.classId);
      streamId = SharedPrefClass.getInt(AppStrings.streamId);
    });
    getClassesModel = await ApiServices().getClassesApi();
    getStreamsModel = await ApiServices()
        .getStreamsApi(classId: SharedPrefClass.getInt(AppStrings.classId));

    // getStreamsModel = await ApiServices().getStreamsApi(class_id: 0);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);

    log('ClassID ${SharedPrefClass.getInt(AppStrings.streamId)}');
    getAllDataBloc.add(OnPressedGetSubjectEvent(
        //  id: SharedPrefClass.getInt(AppStrings.classId),
        streamId: SharedPrefClass.getInt(AppStrings.streamId)));
    getClassesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return SharedPrefClass.getInt(AppStrings.classId) == 0
        ? const SwitchClass()
        : WillPopScope(
            onWillPop: _showDialogForBackButton,
            child: SafeArea(
                child: Scaffold(
                    key: scaffoldKey,
                    drawer: AppWidgets.drawerWidget(),
                    body: BlocConsumer<GetAllDataBloc, GetAllDataState>(
                      listener: ((context, state) {
                        if (state is GetAllDataInitial) {
                          setState(() {
                            loading = state.loading!;
                          });
                        } else if (state is GetSubjectsLoaded) {
                          setState(() {
                            getSubjectList = state.getSubjectModel?.data;
                          });
                        }
                      }),
                      builder: ((context, state) {
                        return SingleChildScrollView(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                children: [
                                  AppWidgets.smallHalfRect(
                                      child: Column(
                                    children: [
                                      AppWidgets.appBarWidget(
                                          isMenu: true,
                                          onTapOnMenu: () => scaffoldKey
                                              .currentState
                                              ?.openDrawer()),
                                      AppWidgets.userInfo(onTapOnIcon: () {
                                        return _showDialogForClass(
                                            context, setState);
                                      }),
                                    ],
                                  )),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Center(
                                    child: Text(
                                      AppStrings.learnToday,
                                      style: AppTextStyles.boldStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  loading == true
                                      ? AppWidgets.circularIndicator()
                                      : getSubjectList!.isEmpty
                                          ? const Center(
                                              child: Text('No Data Found'))
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w),
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      getSubjectList?.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          mainAxisSpacing: 4.w,
                                                          crossAxisSpacing: 4.w,
                                                          childAspectRatio: 3),
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        log('TopicId ${getSubjectList?[index].id.toString()}');
                                                        SharedPrefClass.setInt(
                                                            AppStrings.topicId,
                                                            int.parse(getSubjectList?[
                                                                        index]
                                                                    .id
                                                                    .toString() ??
                                                                ''));

                                                        SharedPrefClass.setString(
                                                            AppStrings
                                                                .subjectName,
                                                            getSubjectList?[
                                                                        index]
                                                                    .name
                                                                    .toString() ??
                                                                '');
                                                        Get.toNamed(
                                                          RouteHelper
                                                              .revisionScreen,
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 2.h,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(4.w),
                                                            gradient: LinearGradient(
                                                                colors: index % 6 == 0
                                                                    ? AppUtils.colorsList[0]
                                                                    : index % 6 == 1
                                                                        ? AppUtils.colorsList[1]
                                                                        : index % 6 == 2
                                                                            ? AppUtils.colorsList[2]
                                                                            : index % 6 == 3
                                                                                ? AppUtils.colorsList[3]
                                                                                : index % 6 == 4
                                                                                    ? AppUtils.colorsList[4]
                                                                                    : AppUtils.colorsList[5])),
                                                        child: Text(
                                                          getSubjectList?[index]
                                                                  .name ??
                                                              '',
                                                          style: AppTextStyles
                                                              .smallTextStyle(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                            ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              )),
                        );
                      }),
                    ))),
          );
  }

  _showDialogForClass(
    BuildContext context,
    StateSetter setState,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return AlertDialog(
              content: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
                // / color: Colors.black,
                width: 100.w,
                alignment: Alignment.center,
                child: DropdownButtonFormField<String>(
                  validator:
                      FormValidation.classValidation(value: classCon.text),
                  decoration: AppWidgets.inputDecoration(
                      hintText: classCon.text.toString()),
                  items: getClassesModel?.data == null
                      ? []
                      : List.generate(getClassesModel!.data!.length, (index) {
                          return DropdownMenuItem<String>(
                            value:
                                getClassesModel?.data?[index].name.toString(),
                            child: Row(
                              children: [
                                Text(
                                  getClassesModel!.data![index].name.toString(),
                                ),
                              ],
                            ),
                            onTap: () async {
                              log('class id${getClassesModel!.data![index].id}');

                              setState(
                                () {
                                  classId = getClassesModel!.data![index].id;
                                  classCon.text = getClassesModel!
                                      .data![index].name
                                      .toString();
                                  streamId = int.parse(getClassesModel!
                                      .data![index].streams
                                      .toString());
                                  log('class COn %${classCon.text}');
                                },
                              );

                              // if (getClassesModel!.data![index].streams
                              //         .toString()
                              //         .contains(',') !=
                              //     true)
                              //   SharedPrefClass.setInt(
                              //       AppStrings.streamId,
                              //       int.parse(getClassesModel!
                              //           .data![index].streams!));
                              //
                              // getStreamsModel?.data = [];
                              //
                              // getStreamsModel = await ApiServices()
                              //     .getStreamsApi(
                              //         class_id:
                              //             getClassesModel!.data![index].id);
                              setState(() {});
                            },
                          );
                        }),
                  onChanged: (Object? value) async {
                    classCon.text = value.toString();
                    getStreamsModel?.data = [];
                    setState(() {});
                  },
                )),
            // if (classCon.text == 'Class 11' || classCon.text == 'Class 12')
            //   SizedBox(
            //     height: 2.h,
            //   ),
            // if (classCon.text == 'Class 11' || classCon.text == 'Class 12')
            //   getStreamsModel?.data == null
            //       ? CircularProgressIndicator()
            //       : Container(
            //           // / color: Colors.black,
            //           width: 100.w,
            //           alignment: Alignment.center,
            //           child: DropdownButtonFormField<String>(
            //             validator: FormValidation.classValidation(
            //                 value: streamCon.text),
            //             decoration: AppWidgets.inputDecoration(
            //                 hintText: 'Select Stream'),
            //             items: getStreamsModel?.data == null
            //                 ? []
            //                 : List.generate(
            //                     getStreamsModel!.data!.length,
            //                     (index) => DropdownMenuItem<String>(
            //                           value: getStreamsModel
            //                               ?.data?[index].name
            //                               .toString(),
            //                           child: Row(
            //                             children: [
            //                               Text(
            //                                 getStreamsModel!.data![index].name
            //                                     .toString(),
            //                               ),
            //                             ],
            //                           ),
            //                           onTap: () {
            //                             streamCon.text = getStreamsModel!
            //                                 .data![index].name
            //                                 .toString();
            //                             streamId =
            //                                 getStreamsModel!.data![index].id;
            //                             setState(() {});
            //                             setState1(() {});
            //                           },
            //                         )),
            //             onChanged: (Object? value) {
            //               setState(() {
            //                 streamCon.text = value.toString();
            //               });
            //               setState1(() {});
            //             },
            //           )),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppWidgets.textButton(onTap: () => Get.back(), text: 'No'),
                SizedBox(
                  width: 2.w,
                ),
                AppWidgets.textButton(
                    onTap: () async {
                      SharedPrefClass.setInt(AppStrings.classId, classId!);
                      SharedPrefClass.setString(
                          AppStrings.selectClass, classCon.text);
                      SharedPrefClass.setInt(AppStrings.streamId, streamId!);
                      SharedPrefClass.setString(
                          AppStrings.selectStream, streamCon.text);
                      Get.back();
                      log('STreammm ${SharedPrefClass.getInt(AppStrings.streamId, defValue: 0)}');

                      getAllDataBloc.add(OnPressedGetSubjectEvent(
                        streamId: SharedPrefClass.getInt(AppStrings.streamId,
                            defValue: 0),
                      ));
                    },
                    text: 'Yes')
              ],
            )
          ]));
        }));
  }

  Future<bool> _showDialogForBackButton() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.w)),
            title: Text('You are about to exit the app? Are you sure?',
                style: AppTextStyles.mediumTextStyle()
                    .copyWith(color: Colors.black)),
            content: Container(
              child: Row(
                children: [
                  Expanded(
                    child: AppWidgets.elevButton(
                        onTap: () => Navigator.of(context).pop(true),
                        text: 'Yes',
                        borderRadius: 3.w),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: AppWidgets.elevButton(
                        onTap: () => Navigator.of(context).pop(false),
                        text: 'No',
                        borderRadius: 3.w),
                  )
                ],
              ),
            ),
          ),
        ) ??
        false;
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
// import 'package:traget_plus/models/get_subjects.dart';
// import 'package:traget_plus/routeHelper/route_helper.dart';
// import 'package:traget_plus/utils/app_strings.dart';
// import 'package:traget_plus/utils/app_textStyles.dart';
// import 'package:traget_plus/utils/app_utils.dart';
// import 'package:traget_plus/utils/app_widget.dart';
// import 'package:traget_plus/utils/sharedPref.dart';
//
// class SubjectScreen extends StatefulWidget {
//   const SubjectScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SubjectScreen> createState() => _SubjectScreenState();
// }
//
// class _SubjectScreenState extends State<SubjectScreen> {
//   GetAllDataBloc getAllDataBloc = GetAllDataBloc();
//   bool loading = true;
//   List<GetSubjectList>? getSubjectList;
//
//   @override
//   void initState() {
//     getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
//
//     log('ClassID ${SharedPrefClass.getInt(AppStrings.streamId)}');
//     getAllDataBloc.add(onPressedGetSubjectEvent(
//         //  id: SharedPrefClass.getInt(AppStrings.classId),
//         stream_id: SharedPrefClass.getInt(AppStrings.streamId)));
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _scaffoldKey = GlobalKey<ScaffoldState>();
//     return SafeArea(
//         child: Scaffold(
//             key: _scaffoldKey,
//             drawer: AppWidgets.drawerWidget(),
//             body: BlocConsumer<GetAllDataBloc, GetAllDataState>(
//               listener: ((context, state) {
//                 if (state is GetAllDataInitial) {
//                   setState(() {
//                     loading = state.loading!;
//                     log('Loading $loading');
//                   });
//                 } else if (state is GetSubjectsLoaded) {
//                   setState(() {
//                     getSubjectList = state.getSubjectModel?.data;
//                   });
//                 }
//               }),
//               builder: ((context, state) {
//                 return SingleChildScrollView(
//                   child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       child: Stack(
//                         alignment: Alignment.topCenter,
//                         children: [
//                           AppWidgets.smallHalfRect(),
//                           Column(
//                             children: [
//                               AppWidgets.appBarWidget(
//                                   onTapOnMenu: () =>
//                                       _scaffoldKey.currentState?.openDrawer()),
//                               AppWidgets.userInfo(),
//                               SizedBox(
//                                 height: 6.h,
//                               ),
//                               Text(
//                                 AppStrings.learnToday,
//                                 style: AppTextStyles.boldStyle(),
//                               ),
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                               Expanded(
//                                 child: loading == true
//                                     ? AppWidgets.circularIndicator()
//                                     : getSubjectList?.length == 0
//                                         ? Container(
//                                             child: Center(
//                                                 child: Text('No Data Found')))
//                                         : Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 4.w),
//                                             child: GridView.builder(
//                                                 shrinkWrap: true,
//                                                 physics:
//                                                     AlwaysScrollableScrollPhysics(),
//                                                 itemCount:
//                                                     getSubjectList?.length,
//                                                 gridDelegate:
//                                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                                         crossAxisCount: 2,
//                                                         mainAxisSpacing: 4.w,
//                                                         crossAxisSpacing: 4.w,
//                                                         childAspectRatio: 3),
//                                                 itemBuilder: ((context, index) {
//                                                   return GestureDetector(
//                                                     onTap: () {
//                                                       SharedPrefClass.setInt(
//                                                           AppStrings.topicId,
//                                                           int.parse(getSubjectList?[
//                                                                       index]
//                                                                   .id
//                                                                   .toString() ??
//                                                               ''));
//
//                                                       SharedPrefClass.setString(
//                                                           AppStrings
//                                                               .subjectName,
//                                                           getSubjectList?[index]
//                                                                   .name
//                                                                   .toString() ??
//                                                               '');
//                                                       Get.toNamed(
//                                                         RouteHelper
//                                                             .revisionScreen,
//                                                       );
//                                                     },
//                                                     child: Container(
//                                                       height: 2.h,
//                                                       alignment:
//                                                           Alignment.center,
//                                                       child: Text(
//                                                         getSubjectList?[index]
//                                                                 .name ??
//                                                             '',
//                                                         style: AppTextStyles
//                                                             .smallTextStyle(),
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                       ),
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       4.w),
//                                                           gradient: LinearGradient(
//                                                               colors: AppUtils
//                                                                       .colorsList[
//                                                                   index])),
//                                                     ),
//                                                   );
//                                                 })),
//                                           ),
//                               ),
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                 );
//               }),
//             )));
//   }
//
//   // _showDialogForClass(
//   //     BuildContext context,
//   //     StateSetter setState,
//   //     ) {
//   //   return showDialog(
//   //       context: context,
//   //       barrierDismissible: false,
//   //       builder: ((context) {
//   //         return StatefulBuilder(builder: ((context, setState1) {
//   //           return AlertDialog(
//   //               content: Column(mainAxisSize: MainAxisSize.min, children: [
//   //                 SizedBox(
//   //                   height: 2.h,
//   //                 ),
//   //                 Container(
//   //                   // / color: Colors.black,
//   //                     width: 100.w,
//   //                     alignment: Alignment.center,
//   //                     child: DropdownButtonFormField<String>(
//   //                       validator:
//   //                       FormValidation.classValidation(value: classCon.text),
//   //                       decoration: AppWidgets.inputDecoration(
//   //                           hintText: classCon.text.toString()),
//   //                       items: getClassesModel?.data == null
//   //                           ? []
//   //                           : List.generate(getClassesModel!.data!.length, (index) {
//   //                         return DropdownMenuItem<String>(
//   //                           value:
//   //                           getClassesModel?.data?[index].name.toString(),
//   //                           child: Row(
//   //                             children: [
//   //                               Text(
//   //                                 getClassesModel!.data![index].name
//   //                                     .toString(),
//   //                               ),
//   //                             ],
//   //                           ),
//   //                           onTap: () async {
//   //                             SharedPrefClass.setInt(AppStrings.classId,
//   //                                 getClassesModel!.data![index].id!);
//   //
//   //                             if (getClassesModel!.data![index].streams
//   //                                 .toString()
//   //                                 .contains(',') !=
//   //                                 true)
//   //                               SharedPrefClass.setInt(
//   //                                   AppStrings.streamId,
//   //                                   int.parse(getClassesModel!
//   //                                       .data![index].streams!));
//   //
//   //                             SharedPrefClass.setString(
//   //                                 AppStrings.selectClass,
//   //                                 getClassesModel!.data![index].name!);
//   //
//   //                             getStreamsModel?.data = [];
//   //
//   //                             getStreamsModel = await ApiServices()
//   //                                 .getStreamsApi(
//   //                                 class_id:
//   //                                 getClassesModel!.data![index].id);
//   //                             setState1(() {});
//   //                             setState(() {});
//   //                           },
//   //                         );
//   //                       }),
//   //                       onChanged: (Object? value) async {
//   //                         classCon.text = value.toString();
//   //                         getStreamsModel?.data = [];
//   //                         setState(() {});
//   //                         setState1(() {});
//   //                       },
//   //                     )),
//   //                 if (classCon.text == 'Class 11' || classCon.text == 'Class 12')
//   //                   SizedBox(
//   //                     height: 2.h,
//   //                   ),
//   //                 if (classCon.text == 'Class 11' || classCon.text == 'Class 12')
//   //                   getStreamsModel?.data == null
//   //                       ? Container()
//   //                       : Container(
//   //                     // / color: Colors.black,
//   //                       width: 100.w,
//   //                       alignment: Alignment.center,
//   //                       child: DropdownButtonFormField<String>(
//   //                         validator: FormValidation.classValidation(
//   //                             value: streamCon.text),
//   //                         decoration: AppWidgets.inputDecoration(
//   //                             hintText: 'Select Stream'),
//   //                         items: getStreamsModel?.data == null
//   //                             ? []
//   //                             : List.generate(
//   //                             getStreamsModel!.data!.length,
//   //                                 (index) => DropdownMenuItem<String>(
//   //                               value: getStreamsModel
//   //                                   ?.data?[index].name
//   //                                   .toString(),
//   //                               child: Row(
//   //                                 children: [
//   //                                   Text(
//   //                                     getStreamsModel!.data![index].name
//   //                                         .toString(),
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                               onTap: () {
//   //                                 SharedPrefClass.setInt(
//   //                                     AppStrings.streamId,
//   //                                     getStreamsModel!
//   //                                         .data![index].id!);
//   //
//   //                                 SharedPrefClass.setString(
//   //                                     AppStrings.selectStream,
//   //                                     getStreamsModel!
//   //                                         .data![index].name!);
//   //                                 setState(() {});
//   //                                 setState1(() {});
//   //                               },
//   //                             )),
//   //                         onChanged: (Object? value) {
//   //                           setState1(() {});
//   //                           setState(() {
//   //                             streamCon.text = value.toString();
//   //                           });
//   //                         },
//   //                       )),
//   //                 SizedBox(
//   //                   height: 2.h,
//   //                 ),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.end,
//   //                   children: [
//   //                     AppWidgets.textButton(onTap: () => Get.back(), text: 'No'),
//   //                     SizedBox(
//   //                       width: 2.w,
//   //                     ),
//   //                     AppWidgets.textButton(
//   //                         onTap: () async {
//   //                           Get.back();
//   //                           log(
//   //                               'STreammm ${SharedPrefClass.getInt(AppStrings.streamId, defValue: 0)}');
//   //
//   //                           getAllDataBloc.add(onPressedGetSubjectEvent(
//   //                             stream_id: SharedPrefClass.getInt(AppStrings.streamId,
//   //                                 defValue: 0),
//   //                           ));
//   //                           Get.back();
//   //                         },
//   //                         text: 'Yes')
//   //                   ],
//   //                 )
//   //               ]));
//   //         }));
//   //       }));
//   // }
// }
