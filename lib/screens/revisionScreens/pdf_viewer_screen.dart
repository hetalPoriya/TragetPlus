import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({Key? key}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool? loading;
  @override
  void initState() {
    loading = true;
    log('AA ${Get.arguments[0]}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          SfPdfViewer.network(
            Get.arguments[0],
            currentSearchTextHighlightColor: AppColors.boxColor1,
            otherSearchTextHighlightColor: AppColors.boxColor2,
            // interactionMode: PdfInteractionMode.selection,
            // enableDocumentLinkAnnotation: false,
            onDocumentLoadFailed: ((details) {
              Fluttertoast.showToast(msg: 'Pdf Not found');
              setState(() {
                loading = false;
              });
            }),
            onDocumentLoaded: ((details) {
              Fluttertoast.showToast(msg: 'Pdf loaded successfully');
              setState(() {
                loading = false;
              });
            }),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 1.h),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
          ),
          if (loading == true) AppWidgets.circularIndicator()
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     AppWidgets.fullRect(
      //       child: AppWidgets.appBarWidgetWithoutTitle(),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 8.w, right: 2.w),
      //       child: Text(
      //         Get.arguments[1],
      //         style: AppTextStyles.smallTextStyle(),
      //         overflow: TextOverflow.ellipsis,
      //       ),
      //     ),
      //     SizedBox(
      //       height: 5.h,
      //     ),
      //     Expanded(
      //         child: SfPdfViewer.network(
      //       Get.arguments[0],
      //       currentSearchTextHighlightColor: AppColors.boxColor1,
      //       otherSearchTextHighlightColor: AppColors.boxColor2,
      //       interactionMode: PdfInteractionMode.selection,
      //       onDocumentLoadFailed: ((details) {
      //         Fluttertoast.showToast(msg: 'Pdf Not found');
      //       }),
      //       onDocumentLoaded: ((details) {
      //         Fluttertoast.showToast(msg: 'Pdf loaded successfully');
      //       }),
      //     )),
      //   ],
      // ),
    )));
  }
}
