import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:traget_plus/screens/payment/payment_config.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../apiService/api_services.dart';
import '../../routeHelper/route_helper.dart';

class GetPremiumMemberShip extends StatefulWidget {
  const GetPremiumMemberShip({Key? key}) : super(key: key);

  @override
  State<GetPremiumMemberShip> createState() => _GetPremiumMemberShipState();
}

class _GetPremiumMemberShipState extends State<GetPremiumMemberShip> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log('Success response ${SharedPrefClass.getInt(AppStrings.id).toString()}');
    log('Success response ${response.paymentId}');
    log('Success response ${response.signature}');
    // log('Success response ${response.toString()}');
    log('Success response ${DateTime.now().millisecondsSinceEpoch.toString()}');
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId.toString());

    await ApiServices()
        .buyPaymentApi(
      amount: '100',
      studentId: SharedPrefClass.getInt(AppStrings.id).toString(),
      status: '1',
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      txnId: response.paymentId.toString(),
    )
        .then((value) {
      Fluttertoast.showToast(msg: 'Transaction successfully completed.');
      SharedPrefClass.setInt(AppStrings.isPremium, 1);
      SharedPrefClass.setString(
          AppStrings.myReferralCode, value?.data['my_referral_code'] ?? ' ');
      Get.toNamed(RouteHelper.paymentSuccessful);
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Error response ${response.code}');
    log('Error response ${response.error}');
    log('Error response ${response.message}');
    Fluttertoast.showToast(
      msg: "ERROR: " +
          response.code.toString() +
          " - " +
          response.message.toString(),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External Wallet response ${response}');
    log('External Wallet response ${response.walletName}');
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName.toString(),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ZHWX27H5RRx9Hp',
      'amount': 100,
      'name': 'hetal',
      'description': 'Payment',
      // 'prefill': {
      //   'contact': SharedPrefClass.getString(AppStrings.userEmail),
      //   'email': SharedPrefClass.getString(AppStrings.userEmail)
      // },
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
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
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Center(
                              child: Text(
                                'Get Premium Membership',
                                style: AppTextStyles.boldStyle(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 1.w,
                            ),
                            Center(
                              child: Text(
                                'What we offer in this class:',
                                style: AppTextStyles.smallTextStyle().copyWith(
                                    color: Colors.black87, fontSize: 11.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    AppWidgets.getPremiumText(
                                        count: '1',
                                        text:
                                            'Chapter wise notes - Hindi Medium/English Medium'),
                                    const Divider(),
                                    AppWidgets.getPremiumText(
                                        count: '2', text: 'Project/MCQ file'),
                                    const Divider(),
                                    AppWidgets.getPremiumText(
                                        count: '3', text: 'Test Series/Book'),
                                    const Divider(),
                                    AppWidgets.getPremiumText(
                                        count: '4', text: 'Sample paper'),
                                    const Divider(),
                                    AppWidgets.getPremiumText(
                                        count: '5', text: 'MCQ test series'),
                                    const Divider(),
                                    AppWidgets.getPremiumText(
                                        count: '6',
                                        text: 'Maths, Science, Hindi, English'),
                                    const Divider(),
                                    Text(
                                      'Become a Member',
                                      style: AppTextStyles.smallTextStyle()
                                          .copyWith(
                                              color: AppColors.darkGrey,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            // SharedPrefClass.setBool(
                                            //     AppStrings.getMemberShipOrNot,
                                            //     true);
                                            //
                                            // // PaytmConfig().generateTxnToken(
                                            // //     1,
                                            // //     SharedPrefClass.getInt(
                                            // //             AppStrings.id)
                                            // //         .toString());
                                            // SharedPrefClass.setInt(
                                            //     AppStrings.isPremium, 1);
                                            // Get.toNamed(
                                            //     RouteHelper.paymentSuccessful);

                                            // Fluttertoast.showToast(
                                            //     msg: 'Please wait...');
                                            openCheckout();
                                            // PaytmConfig().generateTxnToken(
                                            //     499.00,
                                            //     'ORDERID_${SharedPrefClass.getInt(AppStrings.id)}${DateTime.now().millisecondsSinceEpoch.toString()}');
                                            // PaytmConfig().initiateTransaction(
                                            //     'C4',
                                            //     1.0,
                                            //     'uy9V/6xiY5FIkVruFxZhsylBd3Wvzs2DATlH638cYb/47T4XX5pYWcwemZG/8x069rMgeg/g9gd0ooYIJUMohDoDfiubDV4K84Q5qPEJ2xI=',
                                            //     'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=ORDERID_${4}');
                                          },
                                          child: Container(
                                            height: 4.h,
                                            width: 25.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      AppColors.boxColor1,
                                                      AppColors.boxColor2
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(4.w)),
                                            child: Text('Pay Now',
                                                style: AppTextStyles
                                                    .smallTextStyle()),
                                          ),
                                        ),
                                        Text(
                                          'Rs. 499.00',
                                          style: AppTextStyles.smallTextStyle()
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            )));
  }
}
