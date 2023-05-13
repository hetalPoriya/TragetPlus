import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';

class MyNetwork extends StatelessWidget {
  const MyNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    List<DrawerModel> myNetwork = [
      DrawerModel(text: 'My Earning', screenName: RouteHelper.yourEarning),
      DrawerModel(text: 'Invite Earn', screenName: RouteHelper.inviteAndEarn),
      DrawerModel(
          text: 'Transaction', screenName: RouteHelper.transactionHistory),
      DrawerModel(text: 'My Referals', screenName: RouteHelper.myReferrals),
    ];

    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: AppWidgets.drawerWidget(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: ListView(
          children: [
            AppWidgets.smallHalfRect(
                child: Column(
              children: [
                AppWidgets.appBarWidget(),
                AppWidgets.userInfo(),
              ],
            )),
            SizedBox(
              height: 6.h,
            ),
            Center(
              child: Text(
                'My Network',
                style: AppTextStyles.boldStyle(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ListView.builder(
                itemCount: myNetwork.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed(myNetwork[index].screenName.toString()),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Container(
                            height: 7.h,
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
                              myNetwork[index].text,
                              style: AppTextStyles.smallTextStyle(),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  );
                }))
          ],
        ),
        // child: Stack(
        //   children: [
        //   AppWidgets.smallHalfRect(),
        //     Column(
        //       children: [
        //         AppWidgets.appBarWidget(
        //             onTapOnMenu: () =>
        //                 scaffoldKey.currentState?.openDrawer()),
        //         AppWidgets.userInfo(),
        //         SizedBox(
        //           height: 6.h,
        //         ),
        //         Text(
        //           'My Network',
        //           style: AppTextStyles.boldStyle(),
        //         ),
        //         SizedBox(
        //           height: 2.h,
        //         ),
        //         Expanded(child:ListView.builder(
        //             itemCount: myNetwork.length,
        //             shrinkWrap: true,
        //             itemBuilder: ((context, index) {
        //               return Column(
        //                 children: [
        //                   GestureDetector(
        //                     onTap: () => Get.toNamed(
        //                         myNetwork[index].screenName.toString()),
        //                     child: Padding(
        //                       padding: EdgeInsets.symmetric(horizontal: 6.w),
        //                       child: Container(
        //                         height: 7.h,
        //                         child: Center(
        //                             child: Text(
        //                               myNetwork[index].text,
        //                               style: AppTextStyles.smallTextStyle(),
        //                             )),
        //                         decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(4.w),
        //                             gradient: LinearGradient(
        //                                 colors: AppUtils.colorsList[index])),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 2.h,
        //                   ),
        //                 ],
        //               );
        //             })))
        //       ],
        //     )
        //   ],
        // )
      ),
    ));
  }
}
