import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class SelectStream extends StatelessWidget {
  const SelectStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> selectStream = ['PCM', 'PCB', 'Commerce', 'Arts'];
    final scaffldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
        child: Scaffold(
      key: scaffldKey,
      //drawer: AppWidgets.drawerWidget(),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppWidgets.smallHalfRect(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppWidgets.appBarWidget(
                    //     onTapOnMenu: () =>
                    //         scaffldKey.currentState?.openDrawer()),
                    AppWidgets.userInfo(),
                  ],
                )),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Select Stream',
                  style: AppTextStyles.boldStyle(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectStream.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.w,
                          crossAxisSpacing: 4.w,
                          childAspectRatio: 3),
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.samplePaperPdf),
                          child: Container(
                            height: 2.h,
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
                                                        : AppUtils
                                                            .colorsList[5])),
                            child: Center(
                                child: Text(
                              selectStream[index],
                              style: AppTextStyles.smallTextStyle(),
                            )),
                          ),
                        );
                      })),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          )),
    ));
  }
}
