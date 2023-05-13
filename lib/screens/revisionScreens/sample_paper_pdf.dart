import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class SamplePaperPdf extends StatefulWidget {
  const SamplePaperPdf({Key? key}) : super(key: key);

  @override
  State<SamplePaperPdf> createState() => _SamplePaperPdfState();
}

class _SamplePaperPdfState extends State<SamplePaperPdf> {
  String? topicName;
  List<GetTopicsList> getTopicList = [];
  // int? selectedIndex;
  String downloadMsg = 'Loading..';

  // List<bool?>? isDownload;
  CancelToken cancelToken = CancelToken();
  final myPath = Directory(
      "/storage/emulated/0/Download/TargetPlus/${SharedPrefClass.getString(AppStrings.subjectName)}");

  @override
  void initState() {
    topicName = Get.arguments[0];
    log(topicName.toString());
    getTopicList = Get.arguments[1];
    // print('Get.arguments[1] ${Get.arguments[1]}');
    // print('getTopicModel ${SharedPrefClass.getInt(AppStrings.topicId)}');
    // getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    //
    // getAllDataBloc.add(onPressedGetTopicEvent(
    //     subject_id: SharedPrefClass.getInt(AppStrings.topicId),
    //     type: Get.arguments[1]));

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
            children: [
              AppWidgets.fullRect(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppWidgets.appBarWidget(onTapOnBackButton: () => Get.back()),
                  // Get.offAllNamed(RouteHelper.revisionScreen)),
                  SizedBox(
                    height: 1.h,
                  ),
                  AppWidgets.appBarWidgetForRevision(
                      subjectName: SharedPrefClass.getString(
                        AppStrings.subjectName,
                      ),
                      topicName: topicName ?? ' '),
                ],
              )),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 6.w),
              //   child: Text(
              //     'Lorem ipsume Dummy Text',
              //     style: AppTextStyles.extraSmallTextStyle(),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
              (getTopicList.isEmpty || getTopicList == [])
                  ? Container(
                      height: 70.h,
                      alignment: Alignment.center,
                      child: Text(
                        'No Data Found',
                        style: AppTextStyles.smallTextStyle()
                            .copyWith(color: Colors.black),
                      ))
                  : ListView.builder(
                      itemCount: getTopicList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    RouteHelper.pdfViewerScreen,
                                    arguments: [
                                      'https://targetplus.co.in/chd/storage/app/${getTopicList[index].file.toString()}',
                                      getTopicList[index].name
                                    ],
                                  );
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  child: Row(children: [
                                    Expanded(
                                        child: Container(
                                      height: 100.h,
                                      padding: EdgeInsets.all(1.w),
                                      child: CircleAvatar(
                                          backgroundColor: AppColors.darkOrange,
                                          child: Image.asset(AppImages.pdf)),
                                    )),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getTopicList[index].name ?? ' ',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  AppTextStyles.smallTextStyle()
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 1.w,
                                            ),
                                            Text(
                                              '${getTopicList[index].pages} pages | ${getTopicList[index].size}',
                                              style: AppTextStyles
                                                      .extraSmallTextStyle()
                                                  .copyWith(
                                                      color:
                                                          AppColors.darkGrey),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        child: SizedBox(
                                      height: 100.h,
                                      child:
                                          Icon(Icons.remove_red_eye, size: 7.w),
                                    )),
                                  ]),
                                ),
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
          )),
    ));
  }

// Future<bool?> getStoragePermission() async {
//   if (await Permission.storage.request().isGranted) {
//     return true;
//   } else if (await Permission.storage.request().isPermanentlyDenied) {
//     await openAppSettings();
//   } else if (await Permission.storage.request().isDenied) {
//     getStoragePermission();
//   }
// }
//
// Future<String?> createFolderInAppDocDir() async {
//   final path = Directory(
//       "/storage/emulated/0/Download/TargetPlus/${SharedPrefClass.getString(AppStrings.subjectName)}");
//   if ((await path.exists())) {
//     print('Path $path');
//     return path.path;
//   } else {
//     path.create();
//     print('PATH! ${path.path}');
//     print('PATH! ${path.path}');
//     return path.path;
//   }
// }
//
// Future openFile({required String url, String? topicName}) async {
//   getStoragePermission().then((value) {
//     createFolderInAppDocDir().then((value) async {
//       setState(() {
//         loadingPdf = true;
//       });
//
//       final file = await downloadFile(url, topicName, value);
//       if (file == null) return null;
//
//       OpenFile.open(file.path);
//     });
//   });
// }
//
// Future<File?> downloadFile(
//     String url, String? topicName, String? mypath) async {
//   // try {
//   //   print('URL $url');
//   //   Response response = await Dio().download(
//   //     url, '/storage/emulated/0/Download/$topicName.pdf',
//   //     onReceiveProgress: ((count, total) {
//   //       if (total != -1) {
//   //         double percantage = count / total * 100;
//   //         setState(() {
//   //           downloadMsg = 'Downloading..${percantage.floorToDouble()} %';
//   //         });
//   //       }
//   //     }),
//   //     //Received data with List<int>
//   //   );
//   //
//   //   File file = File('/storage/emulated/0/Download/$topicName.pdf');
//   //   var raf = file.openSync(mode: FileMode.write);
//   //   // response.data is List<int> type
//   //   raf.writeFromSync(response.data);
//   //   await raf.close();
//   //   return file;
//   // } catch (e) {
//   //   print('PRINT $e');
//   // }
//   int percantage = 0;
//   try {
//     setState(() {
//       loadingPdf = true;
//     });
//
//     final file =
//         File('$mypath/${topicName.toString().replaceAll(' ', '_')}.pdf');
//
//     final response = await Dio().get(url, onReceiveProgress: ((count, total) {
//       if (total != -1) {
//         percantage = (count / total * 100).round();
//         setState(() {
//           downloadMsg = '${percantage} %';
//         });
//       }
//     }),
//         options: Options(
//             responseType: ResponseType.bytes,
//             receiveTimeout: 0,
//             followRedirects: false));
//
//     print('FILE!@# $file');
//     if (response.statusCode == 200) {
//       final ref = file.openSync(mode: FileMode.write);
//       ref.writeFromSync(response.data);
//       await ref.close();
//       setState(() {
//         loadingPdf = false;
//       });
//       return file;
//     } else if (response.statusCode == 404) {
//       Fluttertoast.showToast(msg: 'Url not found');
//     }
//     return file;
//   } on DioError catch (e) {
//     cancelToken.cancel();
//     loadingPdf = false;
//     percantage = 0;
//     downloadMsg = 'Initializing..';
//     if (e.response?.statusCode == 404) {
//       Fluttertoast.showToast(msg: e.message);
//     } else {
//       Fluttertoast.showToast(msg: 'Something went wrong');
//     }
//     return null;
//   }
// }
//
// Future<bool?> checkPathExitsOrNot({String? name}) async {
//   final path =
//       '/storage/emulated/0/Download/TargetPlus/${SharedPrefClass.getString(AppStrings.subjectName)}/${name.toString().replaceAll(' ', '_')}.pdf';
//
//   print('Path ${File(path).exists()}');
//   if (await (File(path).exists())) {
//     return true;
//   } else {
//     return false;
//   }
// }
}
