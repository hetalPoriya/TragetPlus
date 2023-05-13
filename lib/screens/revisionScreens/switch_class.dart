import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class SwitchClass extends StatefulWidget {
  const SwitchClass({Key? key}) : super(key: key);

  @override
  State<SwitchClass> createState() => _SwitchClassState();
}

class _SwitchClassState extends State<SwitchClass> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  bool loading = true;
  String? className;
  GetClassesModel? getClassesModel;

  getClassesList() async {
    getClassesModel = await ApiServices().getClassesApi();
    //className= SharedPrefClass.getString(AppStrings.selectClass);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getClassesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          AppWidgets.smallHalfRect(
              child: Column(
            children: [
              AppWidgets.appBarWidget(
                  // displayBackButton:
                  //     (SharedPrefClass.getInt(AppStrings.classId) != 0)
                  //         ? true
                  //         : false
                  ),
              AppWidgets.userInfo(),
            ],
          )),
          SizedBox(
            height: 6.h,
          ),
          Center(
            child: Text(
              'Select class',
              style: AppTextStyles.boldStyle(),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          getClassesModel?.data == null
              ? AppWidgets.circularIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: getClassesModel?.data?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.w,
                          crossAxisSpacing: 4.w,
                          childAspectRatio: 3),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (getClassesModel!.data![index].streams != null) {
                              SharedPrefClass.setInt(AppStrings.classId,
                                  getClassesModel!.data![index].id!);
                              SharedPrefClass.setInt(
                                  AppStrings.streamId,
                                  int.parse(getClassesModel!
                                      .data![index].streams
                                      .toString()));
                              SharedPrefClass.setString(
                                  AppStrings.selectClass,
                                  getClassesModel!.data![index].name
                                      .toString());
                              setState(() {});
                              Get.offNamedUntil(
                                  RouteHelper.subjectScreen, (route) => false);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.w),
                                gradient: LinearGradient(
                                    colors: (SharedPrefClass.getInt(
                                                    AppStrings.classId) !=
                                                0 &&
                                            SharedPrefClass.getString(
                                                    AppStrings.selectClass) !=
                                                getClassesModel!
                                                    .data![index].name
                                                    .toString())
                                        ? [
                                            Colors.black26,
                                            Colors.black26,
                                          ]
                                        : index % 6 == 0
                                            ? AppUtils.colorsList[0]
                                            : index % 6 == 1
                                                ? AppUtils.colorsList[1]
                                                : index % 6 == 2
                                                    ? AppUtils.colorsList[2]
                                                    : index % 6 == 3
                                                        ? AppUtils.colorsList[3]
                                                        : index % 6 == 4
                                                            ? AppUtils
                                                                .colorsList[4]
                                                            : AppUtils
                                                                    .colorsList[
                                                                5])),
                            child: Center(
                              child: Text(
                                // getClassesModel!.data![index].name.toString() ==
                                //         'COMPETITION'
                                //     ?
                                getClassesModel!.data![index].name.toString(),
                                // : '${getClassesModel!.data![index].name.toString()}th',
                                style: AppTextStyles.mediumTextStyle(),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
          // Form(
          //     key: _formKey,
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 4.w),
          //       child: Column(
          //         children: [
          //           SizedBox(
          //             height: 2.h,
          //           ),
          //           Container(
          //               width: 100.w,
          //               alignment: Alignment.center,
          //               child: DropdownButtonFormField<String>(
          //                 validator: FormValidation.classValidation(
          //                     value: classCon.text),
          //                 decoration: AppWidgets.inputDecoration(
          //                     hintText: classCon.text.toString()),
          //                 items: getClassesModel?.data == null
          //                     ? []
          //                     : List.generate(getClassesModel!.data!.length,
          //                         (index) {
          //                         return DropdownMenuItem<String>(
          //                           value: getClassesModel?.data?[index].name
          //                               .toString(),
          //                           child: Row(
          //                             children: [
          //                               Text(
          //                                 getClassesModel!.data![index].name
          //                                     .toString(),
          //                               ),
          //                             ],
          //                           ),
          //                           onTap: () async {
          //                             print(
          //                                 'class id ${getClassesModel!.data![index].id}');
          //                             print(
          //                                 'StreamId ${getClassesModel!.data![index].streams.toString()}');
          //
          //                             setState(() {
          //                               classId =
          //                                   getClassesModel!.data![index].id;
          //                               streamId = int.parse(getClassesModel!
          //                                   .data![index].streams
          //                                   .toString());
          //                             });
          //                             // if (getClassesModel!.data![index].streams
          //                             //         .toString()
          //                             //         .contains(',') !=
          //                             //     true)
          //                             //   SharedPrefClass.setInt(
          //                             //       AppStrings.streamId,
          //                             //       int.parse(getClassesModel!
          //                             //           .data![index].streams!));
          //
          //                             // getStreamsModel?.data = [];
          //                             // getStreamsModel = await ApiServices()
          //                             //     .getStreamsApi(
          //                             //         class_id: getClassesModel!
          //                             //             .data![index].id);
          //                           },
          //                         );
          //                       }),
          //                 onChanged: (Object? value) async {
          //                   classCon.text = value.toString();
          //                   // streamCon.text = 'Select Stream';
          //                   // getStreamsModel?.data = [];
          //                   setState(() {});
          //                 },
          //               )),
          //           // if (classCon.text == 'Class 11' ||
          //           //     classCon.text == 'Class 12')
          //           //   SizedBox(
          //           //     height: 2.h,
          //           //   ),
          //           // if (classCon.text == 'Class 11' ||
          //           //     classCon.text == 'Class 12')
          //           //   getStreamsModel?.data == null
          //           //       ? Container()
          //           //       : Container(
          //           //           width: 100.w,
          //           //           alignment: Alignment.center,
          //           //           child: DropdownButtonFormField<String>(
          //           //             validator: FormValidation.classValidation(
          //           //                 value: streamCon.text),
          //           //             decoration: AppWidgets.inputDecoration(
          //           //                 hintText: streamCon.text.toString()),
          //           //             items: getStreamsModel?.data == null
          //           //                 ? []
          //           //                 : List.generate(
          //           //                     getStreamsModel!.data!.length,
          //           //                     (index) => DropdownMenuItem<String>(
          //           //                           value: getStreamsModel!
          //           //                               .data![index].name
          //           //                               .toString(),
          //           //                           child: Row(
          //           //                             children: [
          //           //                               Text(
          //           //                                 getStreamsModel!
          //           //                                     .data![index].name
          //           //                                     .toString(),
          //           //                               ),
          //           //                             ],
          //           //                           ),
          //           //                           onTap: () {
          //           //                             streamId = getStreamsModel!
          //           //                                 .data![index].id;
          //           //                             setState(() {});
          //           //                           },
          //           //                         )),
          //           //             onChanged: (Object? value) {
          //           //               setState(() {
          //           //                 streamCon.text = value.toString();
          //           //               });
          //           //             },
          //           //           )),
          //           SizedBox(
          //             height: 8.h,
          //           ),
          //           AppWidgets.textButton(
          //               width: MediaQuery.of(context).size.width * .80,
          //               onTap: () async {
          //                 SharedPrefClass.clear();
          //                 // if (_formKey.currentState!.validate()) {
          //                 //   print('classCon.text ${classCon.text}');
          //                 //   print('classCon.text ${classId}');
          //                 //   print('streamCon.text ${streamCon.text}');
          //                 //   print('streamCon.text ${streamId}');
          //                 //
          //                 //   SharedPrefClass.setInt(
          //                 //       AppStrings.classId, classId!);
          //                 //   SharedPrefClass.setString(
          //                 //       AppStrings.selectClass, classCon.text);
          //                 //   SharedPrefClass.setInt(
          //                 //       AppStrings.streamId, streamId!);
          //                 //   SharedPrefClass.setString(
          //                 //       AppStrings.selectStream, streamCon.text);
          //                 //   Get.offNamedUntil(
          //                 //       RouteHelper.subjectScreen, (route) => false);
          //                 // }
          //               },
          //               text: 'Switch class'),
          //           SizedBox(
          //             height: 5.h,
          //           ),
          //         ],
          //       ),
          //     ))
        ],
      ),
    ));
  }
}
