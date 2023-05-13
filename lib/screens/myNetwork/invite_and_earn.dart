import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class InviteAndEarn extends StatelessWidget {
  const InviteAndEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Invite & earn',
                        style: AppTextStyles.extraLargeTextStyle().copyWith(
                            color: AppColors.darkGreen,
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Share code to',
                      style: AppTextStyles.extraLargeTextStyle()
                          .copyWith(color: AppColors.darkGrey, fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Join us ',
                      style: AppTextStyles.extraLargeTextStyle().copyWith(
                          color: AppColors.darkGreen, fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const Divider(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    AppWidgets.textButton(
                        onTap: () {
                          FlutterShare.share(
                              title: 'Target Plus',
                              text:
                                  'Target Plus App \nInvite your friends & earn Rs. 300 one time when they become a premium member. You can also generate and earn referral income if your friends bring more users. Ask your friends to use the referral code ${SharedPrefClass.getString(AppStrings.myReferralCode)} during registration.',
                              linkUrl:
                                  'https://play.google.com/store/apps/details?id=com.traget_plus.traget_plus',
                              chooserTitle: 'Target Plus');
                        },
                        text: 'Share',
                        width: 50.w),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
