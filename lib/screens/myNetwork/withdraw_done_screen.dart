import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class WithdrawDoneScreen extends StatefulWidget {
  const WithdrawDoneScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawDoneScreen> createState() => _WithdrawDoneScreenState();
}

class _WithdrawDoneScreenState extends State<WithdrawDoneScreen> {
  TextEditingController amountCon = TextEditingController();
  TextEditingController upiCon = TextEditingController();
  TextEditingController phoneNoCon = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  WithdawModel? withdawModel;
  bool? loading;
  String? text;

  @override
  void initState() {
    text = Get.arguments[0].toString();
    upiCon.text = SharedPrefClass.getString(AppStrings.userUpi);
    phoneNoCon.text = SharedPrefClass.getString(AppStrings.userPaymentNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: AppWidgets.appBarWithImage(
        appBarWidget: AppWidgets.appBarWidget(),
        middleCardWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Material(
            borderRadius: BorderRadius.circular(6.w),
            elevation: 4,
            child: Container(
              height: 60.h,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'Your Earning',
                          style: AppTextStyles.boldStyle(),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Wallet Balance ',
                            style: AppTextStyles.largeTextStyle()
                                .copyWith(color: AppColors.darkGrey),
                            children: [
                              TextSpan(
                                text: text ?? ' ',
                                style: AppTextStyles.largeTextStyle()
                                    .copyWith(color: Colors.black),
                              ),
                              const TextSpan(
                                text: ' minimum balance requird ',
                              ),
                              TextSpan(
                                text: 'Rs.300 ',
                                style: AppTextStyles.largeTextStyle()
                                    .copyWith(color: Colors.black),
                              ),
                              const TextSpan(
                                text: 'you can go ',
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AppWidgets.editProfileTextFormFieldWidget(
                                lableText: 'Enter Amount',
                                radius: 2.w,
                                hintText: 'Enter Amount',
                                validator: FormValidation.emptyValidation(
                                    value: amountCon.text),
                                textEditingController: amountCon,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next),
                            SizedBox(
                              height: 2.h,
                            ),
                            AppWidgets.editProfileTextFormFieldWidget(
                                lableText: 'Enter Your Upi',
                                radius: 2.w,
                                hintText: 'Enter Your Upi',
                                validator: FormValidation.emptyValidation(
                                    value: upiCon.text),
                                textEditingController: upiCon,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next),
                            SizedBox(
                              height: 2.h,
                            ),
                            AppWidgets.editProfileTextFormFieldWidget(
                                lableText: 'Enter Your PhoneNo',
                                radius: 2.w,
                                hintText: 'Enter Your PhoneNo',
                                validator:
                                    FormValidation.mobileNumberValidation(
                                        value: phoneNoCon.text),
                                textEditingController: phoneNoCon,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            SharedPrefClass.setString(
                                AppStrings.userUpi, upiCon.text);
                            SharedPrefClass.setString(
                                AppStrings.userPaymentNumber, phoneNoCon.text);

                            withdawModel = await ApiServices()
                                .withdrawAmountApi(
                                    amount: amountCon.text.toString(),
                                    parentCode: SharedPrefClass.getString(
                                        AppStrings.myReferralCode),
                                    upi: upiCon.text,
                                    mobileWithdraw: phoneNoCon.text);
                            setState(() {
                              loading = false;
                            });
                          }

                          // Get.toNamed(RouteHelper.congratsScreen);
                        },
                        child: Container(
                          width: 40.w,
                          height: 6.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              gradient: LinearGradient(colors: [
                                AppColors.darkOrange,
                                AppColors.lightOrange
                              ])),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Done',
                                  style: AppTextStyles.mediumTextStyle()),
                              if (loading == true)
                                SizedBox(
                                  width: 1.w,
                                ),
                              if (loading == true)
                                SizedBox(
                                  height: 3.h,
                                  width: 6.w,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
