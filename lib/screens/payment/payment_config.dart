import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import '../../routeHelper/route_helper.dart';

class PaytmConfig {
  // //testing
  // final String _mid = "tvysyF91127148549956";
  // final String _mKey = "F7f1QkF68bJW4mxD";
  // final String _website = "WEBSTAGING";

  //live
  final String _mid = "MbZdTn14962972163693";
  final String _mKey = "DBBVBI0spVtx3k#N";
  final String _website = "DEFAULT";

  final String _url =
      'https://targetplus.co.in/chd/api/v1/${AppStrings.paytmChecksum}';

  String get mid => _mid;

  String get mKey => _mKey;

  String get website => _website;

  String get url => _url;

  String getMap(double amount, String callbackUrl, String orderId) {
    return json.encode({
      "mid": mid,
      "key_secret": mKey,
      "website": website,
      "orderId": orderId,
      "amount": amount,
      "callbackUrl": callbackUrl,
      "custId": "C${SharedPrefClass.getInt(AppStrings.id)}",
    });
  }

  Future<void> generateTxnToken(double amount, String orderId) async {
    // //test
    // final callBackUrl =
    //     'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';

    // live
    final callBackUrl =
        'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';

    final body = getMap(amount, callBackUrl, orderId);

    try {
      final response = await Dio().post(
        url,
        data: body,
      );
      // final response = await http.post(
      //   Uri.parse(url),
      //   body: body,
      //   headers: {'Content-type': "application/json"},
      // );
      String txnToken = response.data;
      Map<String, dynamic> txt = jsonDecode(txnToken);
      if (txt['Data']['body']['resultInfo']['resultStatus'] == 'S') {
        // Fluttertoast.showToast(
        //     msg: txt['Data']['body']['resultInfo']['resultMsg']);
        await initiateTransaction(
            orderId, amount, txt['Data']['body']['txnToken'], callBackUrl);
      } else {
        // Fluttertoast.showToast(
        //     msg: txt['Data']['body']['resultInfo']['resultMsg']);
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR ${e.toString()}');
      }
    }
  }

  Future<void> initiateTransaction(String orderId, double amount,
      String txnToken, String callBackUrl) async {
    try {
      var response = AllInOneSdk.startTransaction(mid, orderId,
          amount.toStringAsFixed(2), txnToken, callBackUrl, false, false);

      response.then((value) async {
        // Transaction successfull

        //SharedPrefClass.setBool(AppStrings.getMemberShipOrNot, true);

        await ApiServices()
            .buyPaymentApi(
          amount: value?['TXNAMOUNT'],
          studentId: SharedPrefClass.getInt(AppStrings.id).toString(),
          method: value?['PAYMENTMODE'],
          status: '1',
          time: value?['TXNDATE'],
          txnId: value?['TXNID'],
        )
            .then((value) {
          Fluttertoast.showToast(msg: 'Transaction successfully completed.');
          SharedPrefClass.setInt(AppStrings.isPremium, 1);
          SharedPrefClass.setString(AppStrings.myReferralCode,
              value?.data['my_referral_code'] ?? ' ');
          Get.toNamed(RouteHelper.paymentSuccessful);
        });
      }).catchError((onError) {
        ApiServices().buyPaymentApi(
            amount: onError.details?['TXNAMOUNT'],
            studentId: SharedPrefClass.getInt(AppStrings.id).toString(),
            method: onError.details?['PAYMENTMODE'],
            status: '0',
            time: onError.details?['TXNDATE'],
            txnId: onError.details?['TXNID']);
        Fluttertoast.showToast(msg: 'Transaction Failed');
        if (onError is PlatformException) {
          // Fluttertoast.showToast(msg: onError.message.toString());
        } else {
          //  Fluttertoast.showToast(msg: result);
        }
      });
    } catch (err) {
      // Transaction failed
      //Fluttertoast.showToast(msg: result);
    }
  }
}
