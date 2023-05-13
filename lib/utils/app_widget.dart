import 'package:flutter/material.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import 'utils.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AppWidgets {
  static List<DrawerModel> drawerModel = [
    DrawerModel(
        text: 'Home',
        imageString: AppImages.home,
        screenName: RouteHelper.mainScreen),
    DrawerModel(
        text: 'Dashboard',
        imageString: AppImages.dashboard,
        screenName: RouteHelper.subjectScreen),
    DrawerModel(
        text: 'My Profile',
        imageString: AppImages.profile,
        screenName: RouteHelper.editProfile),
    DrawerModel(
        text: 'Switch Class',
        imageString: AppImages.dashboard,
        screenName: RouteHelper.switchClass),
    DrawerModel(
        text: 'My Transaction',
        imageString: AppImages.transaction,
        screenName: RouteHelper.transactionHistory),
    DrawerModel(
        text: 'Invite & Earn',
        imageString: AppImages.inviteEarn,
        screenName: RouteHelper.inviteAndEarn),
    // DrawerModel(
    //     text: 'Feedback',
    //     imageString: AppImages.feedback,
    //     screenName: RouteHelper.subjectScreen),
    DrawerModel(
        text: 'My Network',
        imageString: AppImages.network,
        screenName: RouteHelper.myNetwork),
    DrawerModel(
        text: 'Terms & Conditions',
        imageString: AppImages.dashboard,
        screenName: RouteHelper.termsAndConditions),
    DrawerModel(
        text: 'Rate Us', imageString: AppImages.dashboard, screenName: ''),
    DrawerModel(
        text: 'About Us',
        imageString: AppImages.dashboard,
        screenName: RouteHelper.aboutUs),
    DrawerModel(
      text: 'Log Out',
      imageString: AppImages.logout,
    ),
  ];

  static InputDecoration inputDecoration(
          {String? hintText, double? radius, Widget? suffixWidget}) =>
      InputDecoration(
        contentPadding: EdgeInsets.all(4.w),
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: hintText,
        suffixIcon: suffixWidget,
        hintStyle: AppTextStyles.smallTextStyle()
            .copyWith(color: Colors.grey.shade700),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 6.w),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 6.w),
            borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 6.w),
            borderSide: BorderSide(color: Colors.grey.shade200)),
      );

  static Widget textFormFieldWidget(
          {String? hintText,
          TextEditingController? textEditingController,
          bool? obscureText,
          TextInputType? textInputType,
          TextInputAction? textInputAction,
          String? Function(String?)? validator,
          double? radius,
          Widget? suffixWidget,
          bool? readOnly}) =>
      TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          obscureText: obscureText ?? false,
          keyboardType: textInputType,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: textEditingController,
          decoration: inputDecoration(
              hintText: hintText, radius: radius, suffixWidget: suffixWidget));

  static Widget editProfileTextFormFieldWidget(
          {String? hintText,
          TextEditingController? textEditingController,
          bool? obscureText,
          TextInputType? textInputType,
          TextInputAction? textInputAction,
          String? Function(String?)? validator,
          double? radius,
          Widget? suffixWidget,
          bool? readOnly,
          String? lableText}) =>
      TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          obscureText: obscureText ?? false,
          keyboardType: textInputType,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: textEditingController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(4.w),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: hintText,
            suffixIcon: suffixWidget,
            hintStyle: AppTextStyles.smallTextStyle()
                .copyWith(color: Colors.grey.shade700),
            labelText: lableText,
            labelStyle:
                AppTextStyles.smallTextStyle().copyWith(color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 2.w),
                borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 2.w),
                borderSide: const BorderSide(color: Colors.black)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 2.w),
                borderSide: BorderSide(color: Colors.grey.shade200)),
          ));

  static Widget richTextWigdetForTermsAndCon() => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: AppTextStyles.extraSmallTextStyle()
              .copyWith(color: AppColors.lightGrey),
          text: AppStrings.byCon,
          children: [
            TextSpan(
              text: AppStrings.signUp,
              style:
                  AppTextStyles.smallTextStyle().copyWith(color: Colors.black),
            ),
            TextSpan(
              text: AppStrings.agrees,
            ),
            TextSpan(
              text: AppStrings.termsAndCondition,
              style:
                  AppTextStyles.smallTextStyle().copyWith(color: Colors.black),
            ),
            TextSpan(
              text: AppStrings.withoutReservation,
            ),
          ]));

  static Widget richTextWidgetForAlreadyHaveAcc(
          {String? signUpOrIn, String? accountOrNot, VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
              text: accountOrNot,
              style: AppTextStyles.mediumTextStyle()
                  .copyWith(color: AppColors.lightGrey),
              children: [
                TextSpan(
                    text: signUpOrIn,
                    style: AppTextStyles.mediumTextStyle()
                        .copyWith(color: AppColors.darkOrange))
              ]),
        ),
      );

  static Widget elevButton(
          {VoidCallback? onTap, String? text, double? borderRadius}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 6.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 6.w),
              gradient: LinearGradient(
                  colors: [AppColors.darkOrange, AppColors.lightOrange])),
          child: Text(text.toString(), style: AppTextStyles.mediumTextStyle()),
        ),
      );

  static Widget appBarWidget(
          {VoidCallback? onTapOnMenu,
          bool isMenu = false,
          VoidCallback? onTapOnBackButton}) =>
      SizedBox(
        height: 10.h,
        width: double.infinity,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topRight,
                    image: AssetImage(AppImages.halfCircle))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: isMenu == false
                        ? GestureDetector(
                            onTap: onTapOnBackButton ?? () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                          )
                        : GestureDetector(
                            onTap: onTapOnMenu,
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 10.w,
                            ),
                          ),
                  )),
                  Expanded(
                      child: Text(
                    AppStrings.learningApp,
                    style: AppTextStyles.smallTextStyle()
                        .copyWith(fontSize: 13.sp),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Icon(Icons.search, color: Colors.white),
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed(RouteHelper.notificationScreen),
                        child: const Icon(Icons.notifications_none,
                            color: Colors.white),
                      ),
                    ],
                  )),
                ],
              ),
            )),
      );

  // static Widget appBarWidgetWithoutTitle({void Function()? onTap}) => SizedBox(
  //       height: 10.h,
  //       width: double.infinity,
  //       child: Container(
  //           decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   alignment: Alignment.topRight,
  //                   image: AssetImage(AppImages.halfCircle))),
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 6.w),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                     child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: GestureDetector(
  //                     onTap: onTap ?? () => Get.back(),
  //                     child: Icon(
  //                       Icons.arrow_back_ios_rounded,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     // Icon(Icons.search, color: Colors.white),
  //                     // SizedBox(
  //                     //   width: 2.w,
  //                     // ),
  //                     // Icon(Icons.notifications_none, color: Colors.white),
  //                   ],
  //                 )),
  //               ],
  //             ),
  //           )),
  //     );

  // static Widget appBarWidgetForFullRect({bool displayBackButton = true}) =>
  //     SizedBox(
  //       height: 10.h,
  //       width: double.infinity,
  //       child: Container(
  //           decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   alignment: Alignment.topRight,
  //                   image: AssetImage(AppImages.halfCircle))),
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 6.w),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                     child: Visibility(
  //                   visible: displayBackButton,
  //                   child: Align(
  //                     alignment: Alignment.centerLeft,
  //                     child: GestureDetector(
  //                       onTap: () => Get.back(),
  //                       child: Icon(
  //                         Icons.arrow_back_ios_rounded,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     flex: 2,
  //                     child: Align(
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         'Learning App',
  //                         style: AppTextStyles.mediumTextStyle(),
  //                       ),
  //                     )),
  //                 Expanded(
  //                     child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     // Icon(Icons.search, color: Colors.white),
  //                     // SizedBox(
  //                     //   width: 2.w,
  //                     // ),
  //                     GestureDetector(
  //                       onTap: () =>
  //                           Get.toNamed(RouteHelper.notificationScreen),
  //                       child:
  //                           Icon(Icons.notifications_none, color: Colors.white),
  //                     ),
  //                   ],
  //                 )),
  //               ],
  //             ),
  //           )),
  //     );

  static Widget getPremiumText({String? count, String? text}) => Row(
        children: [
          Flexible(
            flex: 1,
            child: CircleAvatar(
                backgroundColor: AppColors.boxColor2,
                child: Text(
                  count.toString(),
                  style: AppTextStyles.mediumTextStyle(),
                )),
          ),
          SizedBox(
            width: 4.w,
          ),
          Flexible(
            flex: 4,
            child: Text(text.toString(),
                style: AppTextStyles.smallTextStyle()
                    .copyWith(color: Colors.black87, fontSize: 11.sp)),
          ),
        ],
      );

  static Widget fullRect({double? height, Widget? child}) => Container(
        height: height ?? 18.h,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.fullRect), fit: BoxFit.fill)),
        child: child,
      );

  static Widget smallHalfRect({Widget? child}) => Container(
        height: 28.h,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.smallHalfRect), fit: BoxFit.fill)),
        child: child,
      );

  static Widget bigHalfRect({Widget? child}) => Container(
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.bigHalfRect), fit: BoxFit.fill)),
        child: child,
      );

  static Widget userInfo({
    VoidCallback? onTapOnIcon,
  }) =>
      SizedBox(
        height: 14.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
              height: 8.h,
              child: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 4.h),
              ),
            )),
            Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      SharedPrefClass.getString(AppStrings.studentName) == ''
                          ? 'UserName'
                          : SharedPrefClass.getString(AppStrings.studentName),
                      style: AppTextStyles.mediumTextStyle(),
                    )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        (SharedPrefClass.getInt(AppStrings.classId) == 0)
                            ? Text(
                                SharedPrefClass.getString(
                                            AppStrings.myReferralCode) ==
                                        ' '
                                    ? 'Referral Code'
                                    : SharedPrefClass.getString(
                                        AppStrings.myReferralCode),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.smallTextStyle()
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            : Text(
                                SharedPrefClass.getString(
                                            AppStrings.selectClass) ==
                                        ''
                                    ? 'ClassName'
                                    : SharedPrefClass.getString(
                                        AppStrings.selectClass),
                                style: AppTextStyles.smallTextStyle()
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                        // GestureDetector(
                        //     onTap: onTapOnIcon,
                        //     child:
                        // Icon(
                        //   Icons.arrow_drop_down_rounded,
                        //   size: 10.w,
                        //   color: Colors.white,
                        // )
                        // )
                      ],
                    ),
                    // Flexible(
                    //     child: Text(
                    //   'CBSE, Board Exam',
                    //   style: AppTextStyles.extraSmallTextStyle()
                    //       .copyWith(fontWeight: FontWeight.w400),
                    // )),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    // Flexible(
                    //     child: Row(
                    //   children: [
                    //     // Text(
                    //     //   SharedPrefClass.getString(AppStrings.selectClass),
                    //     //   style: AppTextStyles.smallTextStyle()
                    //     //       .copyWith(fontWeight: FontWeight.w400),
                    //     // ),
                    //     // GestureDetector(
                    //     //     onTap: onTapOnIcon,
                    //     //     child: Icon(
                    //     //       Icons.arrow_drop_down_rounded,
                    //     //       size: 10.w,
                    //     //     ))
                    //   ],
                    // ))
                  ]),
            )
          ],
        ),
      );

  static Widget appBarWithImage(
          {required Widget middleCardWidget,
          VoidCallback? onTapOnMenu,
          Widget? appBarWidget}) =>
      SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                AppWidgets.bigHalfRect(),
                OrientationBuilder(builder: ((context, orientation) {
                  return Column(
                    children: [
                      appBarWidget ??
                          AppWidgets.appBarWidget(onTapOnMenu: onTapOnMenu),
                      SizedBox(
                        height: 1.h,
                      ),
                      AppWidgets.userInfo(),
                      SizedBox(
                        height: 2.h,
                      ),
                      middleCardWidget,
                      SizedBox(
                        height: 2.h,
                      )
                    ],
                  );
                }))
              ],
            ),
          ));

  static Widget drawerWidget() => Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          height: 90.h,
          width: 80.w,
          child: Drawer(
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 7.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: Colors.white54,
                      ),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: SizedBox(
                          height: 8.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.person, size: 4.h),
                          ),
                        )),
                        Expanded(
                          flex: 3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (SharedPrefClass.getBool(
                                        AppStrings.isLogin, false) ==
                                    false) ...[
                                  Flexible(
                                      child: Text(
                                    'Target Plus',
                                    style: AppTextStyles.mediumTextStyle(),
                                  )),
                                ] else ...[
                                  Flexible(
                                      child: Text(
                                    SharedPrefClass.getString(
                                                AppStrings.studentName) ==
                                            ''
                                        ? 'UserName'
                                        : SharedPrefClass.getString(
                                            AppStrings.studentName),
                                    style: AppTextStyles.mediumTextStyle(),
                                  )),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    SharedPrefClass.getString(
                                                AppStrings.myReferralCode) ==
                                            ' '
                                        ? 'Referral Code'
                                        : SharedPrefClass.getString(
                                            AppStrings.myReferralCode),
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.smallTextStyle()
                                        .copyWith(fontWeight: FontWeight.w400),
                                  )
                                ]
                              ]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  (SharedPrefClass.getInt(AppStrings.isPremium) == 1)
                      ? ListView.builder(
                          itemCount: drawerModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (index == drawerModel.length - 1) {
                                      Get.back();
                                      showDialogForLogOut(context);
                                    } else {
                                      Get.back();
                                      drawerModel[index].text == 'Rate Us'
                                          ? launchURLBrowser()
                                          : Get.toNamed(drawerModel[index]
                                              .screenName
                                              .toString());
                                    }
                                  },
                                  leading: Image.asset(
                                      drawerModel[index].imageString.toString(),
                                      height: 4.h,
                                      width: 8.w,
                                      color: Colors.white),
                                  title: Text(drawerModel[index].text,
                                      style: AppTextStyles.smallTextStyle()),
                                ),
                                const Divider(
                                  color: Colors.white,
                                )
                              ],
                            );
                          }))
                      : ListTile(
                          onTap: () => launchURLBrowser(),
                          leading: Image.asset(AppImages.dashboard,
                              height: 4.h, width: 8.w),
                          title: Text('Rate Us',
                              style: AppTextStyles.smallTextStyle()),
                        ),
                ]),
              ),
            ),
          ),
        ),
      );

  static launchURLBrowser() async {
    var url = Uri.parse("market://details?id=com.traget_plus.traget_plus");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Widget tabWidget({GetTransactionModel? getTransactionModel}) =>
      ListView.builder(
        itemCount: getTransactionModel?.data?.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                height: 7.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                                  getTransactionModel!.data![index].txnDate!) ??
                              ' ',
                          style: AppTextStyles.extraSmallTextStyle()
                              .copyWith(color: AppColors.darkGrey),
                        ),
                        Text(
                          getTransactionModel.data?[index].amountForName
                                  .toString() ??
                              ' ',
                          style: AppTextStyles.mediumTextStyle()
                              .copyWith(color: Colors.black),
                        )
                      ],
                    ),
                    Text(
                      getTransactionModel.data?[index].amount.toString() ?? ' ',
                      style: AppTextStyles.extraSmallTextStyle().copyWith(
                          color: getTransactionModel.data?[index].txnType
                                      .toString() ==
                                  'CREDIT'
                              ? AppColors.darkGreen
                              : Colors.red),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              if (index == (getTransactionModel.data?.length)! - 1)
                SizedBox(
                  height: 2.h,
                ),
            ],
          );
        },
      );

  static Widget circularIndicator() => Center(
          child: CircularProgressIndicator(
        backgroundColor: AppColors.boxColor1,
        color: AppColors.lightGrey,
      ));

  static Widget textButton(
          {VoidCallback? onTap, String? text, double? width}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 5.h,
          width: width ?? 20.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.w),
              gradient: LinearGradient(
                  colors: [AppColors.darkOrange, AppColors.lightOrange])),
          child: Text(text.toString(), style: AppTextStyles.mediumTextStyle()),
        ),
      );

  static Widget getClassAndStream() => Container();

  static Future<dynamic> showDialogForLogOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.boxColor1,
          title: Text('Logout', style: AppTextStyles.mediumTextStyle()),
          content: Text(AppStrings.logOutOrNot,
              style: AppTextStyles.smallTextStyle()),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'No',
                  style: AppTextStyles.smallTextStyle(),
                )),
            TextButton(
                onPressed: () {
                  Get.back();
                  SharedPrefClass.setBool(AppStrings.isLogin, false);
                  SharedPrefClass.setInt(AppStrings.isPremium, 0);
                  SharedPrefClass.setString(AppStrings.userPaymentNumber, '');
                  SharedPrefClass.setString(AppStrings.userUpi, '');
                  SharedPrefClass.clear();
                  Get.offNamedUntil(RouteHelper.signIn, (route) => false);
                },
                child: Text(
                  'Yes',
                  style: AppTextStyles.smallTextStyle(),
                )),
          ],
        );
      },
    );
  }

  static Widget rowForResult({String? text, String? marks}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Text(text ?? '',
                style: AppTextStyles.smallTextStyle()
                    .copyWith(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(marks ?? '',
                style: AppTextStyles.smallTextStyle()
                    .copyWith(color: AppColors.lightGreen)),
          )
        ],
      );

  static Widget earningRow({String? text, String? amount}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text.toString(),
                style: AppTextStyles.smallTextStyle().copyWith(
                  color: AppColors.darkGrey,
                ),
              ),
              Text(amount.toString(),
                  style: AppTextStyles.boldStyle().copyWith(fontSize: 12.sp))
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Divider(
            color: AppColors.darkGrey,
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }

  static titleText({String? text}) => Text(
        text.toString(),
        style: AppTextStyles.mediumTextStyle().copyWith(color: Colors.black),
      );

  static largeText({String? text, TextDecoration? decoration}) => Text(
        text.toString(),
        style: AppTextStyles.extraLargeTextStyle().copyWith(
            color: Colors.black,
            decoration: decoration ?? TextDecoration.underline),
      );

  static normalText({String? text}) => Text(
        text.toString(),
        textAlign: TextAlign.justify,
        style: AppTextStyles.smallTextStyle().copyWith(
          color: Colors.black,
        ),
      );

  static smallSizedBox() => SizedBox(
        height: 2.h,
      );

  static appBarWidgetForRevision(
          {required String subjectName, required String topicName}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subjectName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyles.smallTextStyle(),
            ),
            Text(
              topicName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyles.extraSmallTextStyle(),
            ),
          ],
        ),
      );
}
