import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:traget_plus/models/models.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:traget_plus/utils/utils.dart';

class ApiServices {
  Dio dio = Dio();
  String baseUrl = 'https://targetplus.co.in/chd/api/v1/';

  //'http://sh021.hostgator.tempwebhost.net/~synraiar/chd/api/v1/';

  loginApi({String? username, String? password}) async {
    LoginModel? loginModel;
    try {
      var formData =
          FormData.fromMap({'username': username, 'password': password});
      var response = await dio.post(
        baseUrl + AppStrings.loginUrl,
        data: formData,
      );
      if (response.data['error'] == 'password not match') {
        Fluttertoast.showToast(msg: 'password not match');
      } else {
        Fluttertoast.showToast(msg: 'Success');
        SharedPrefClass.clear();
        loginModel = LoginModel.fromMap(response.data);
        SharedPrefClass.setBool(AppStrings.isLogin, true);
        // SharedPrefClass.setInt(AppStrings.classId, response.data['class']);
        // SharedPrefClass.setString(
        //     AppStrings.selectClass, response.data['class_name']);
        // SharedPrefClass.setString(
        //     AppStrings.selectStream, response.data['stream_name']);
        // SharedPrefClass.setInt(AppStrings.streamId, response.data['stream']);

        SharedPrefClass.setInt(
            AppStrings.isPremium, response.data['is_premium']);
        SharedPrefClass.setInt(AppStrings.id, response.data['id']);
        SharedPrefClass.setString(
            AppStrings.studentName, response.data['name']);
        SharedPrefClass.setString(AppStrings.userAdd, response.data['address']);
        SharedPrefClass.setString(
            AppStrings.userUpi, response.data['upi'] ?? '');
        // SharedPrefClass.setString(
        //     AppStrings.myReferralCode, response.data['referral_code']);
        // SharedPrefClass.setString(
        //     AppStrings.myReferralCodeUser, response.data['my_referral_code']);

        SharedPrefClass.setString(AppStrings.myReferralCode,
            response.data['my_referral_code'] ?? ' ');
        SharedPrefClass.setString(AppStrings.myReferralCodeUser,
            response.data['referral_code'] ?? ' ');
        SharedPrefClass.setUserData(jsonEncode(response.data));
        // String? login = await SharedPrefClass.getUserData();
        // Map<String, dynamic> data = jsonDecode(login);

        // SharedPrefClass.getBool(AppStrings.getMemberShipOrNot, false) == true
        //     ? Get.offNamedUntil(RouteHelper.subjectScreen, (route) => false)
        //     : Get.offAllNamed(RouteHelper.mainScreen);

        // SharedPrefClass.getInt(AppStrings.isPremium) == 1
        //     ? Get.offNamedUntil(RouteHelper.subjectScreen, (route) => false)
        //     :
        Get.offAllNamed(RouteHelper.mainScreen);
        return loginModel;
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  signUpApi({required LoginModel login}) async {
    LoginModel? loginModel;

    try {
      var formData = FormData.fromMap({
        'name': login.name,
        'email': login.email,
        'mobile': login.mobile,
        'address': login.address,
        'referral_code': login.referralCode,
        'class': 0,
        'stream': 0,
        'password': login.password,
      });
      var response =
          await dio.post(baseUrl + AppStrings.registersUrl, data: formData);

      if (response.data.toString().contains('status')) {
        loginModel = LoginModel.fromMap(response.data);
        SharedPrefClass.setBool(AppStrings.isLogin, true);
        SharedPrefClass.setInt(AppStrings.id, response.data['id']);
        //   SharedPrefClass.setBool(AppStrings.getMemberShipOrNot, false);
        SharedPrefClass.setInt(AppStrings.isPremium, 0);
        SharedPrefClass.setString(
            AppStrings.studentName, response.data['name']);
        SharedPrefClass.setString(
            AppStrings.userPassword, response.data['o_password']);
        SharedPrefClass.setString(AppStrings.userAdd, response.data['address']);
        SharedPrefClass.setUserData(jsonEncode(response.data));
        // SharedPrefClass.setString(
        //     AppStrings.myReferralCode, response.data['referral_code']);
        // SharedPrefClass.setString(
        //     AppStrings.myReferralCodeUser, response.data['my_referral_code']);
        SharedPrefClass.setString(AppStrings.myReferralCode,
            response.data['my_referral_code'] ?? ' ');
        SharedPrefClass.setString(AppStrings.myReferralCodeUser,
            response.data['referral_code'] ?? ' ');

        // String login = await SharedPrefClass.getUserData();
        // Map<String, dynamic> data = jsonDecode(login);
        // print('Data ${data['mobile']}');

        Fluttertoast.showToast(msg: 'Success');
        Get.offAllNamed(RouteHelper.mainScreen);
        return loginModel;
      } else {
        ErrorModel? errorModel;
        errorModel = ErrorModel.fromMap(response.data);
        if (errorModel.mobile?[0].toString() ==
            'The mobile has already been taken.') {
          Fluttertoast.showToast(msg: 'The mobile has already been taken.');
        } else if (errorModel.email?[0].toString() ==
            'The email has already been taken.') {
          Fluttertoast.showToast(msg: 'The email has already been taken.');
        } else if (errorModel.referralCode?[0].toString() ==
            'The selected referral code is invalid.') {
          Fluttertoast.showToast(msg: 'The selected referral code is invalid.');
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  Future<void> updateProfileApi(
      {int? id,
      String? username,
      String? address,
      String? upi,
      String? mobileWithdraw}) async {
    try {
      var formData = FormData.fromMap({
        'id': id,
        'username': username,
        'address': address,
        'upi': upi,
        'mobile_withdraw': mobileWithdraw
      });
      await dio.post(
        baseUrl + AppStrings.updateProfileUrl,
        data: formData,
      );
      Fluttertoast.showToast(msg: 'Saved successfully');
      Get.offAllNamed(RouteHelper.subjectScreen);
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  Future<void> chnagePassApi(
      {int? id, String? oldPassword, String? password}) async {
    try {
      var formData = FormData.fromMap({
        'id': id,
        'old_password': oldPassword,
        'password': password,
      });
      var response = await dio.post(baseUrl + AppStrings.changePasswordUrl,
          data: formData);
      if (response.data['Status'] == true) {
        Fluttertoast.showToast(msg: response.data['Data'].toString());
        Get.offAllNamed(RouteHelper.signIn);
      } else {
        Fluttertoast.showToast(msg: 'Old password not match');
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  Future<void> getChangePasswordDetails({String? email}) async {
    try {
      var response = await dio
          .get('${baseUrl + AppStrings.changePasswordUrl}?username=$email');
      LoginModel.fromMap(response.data);
      if (response.data['Status'] == false) {
        Fluttertoast.showToast(msg: 'Please enter valid email');
      } else {
        SharedPrefClass.setString(
            AppStrings.userPassword, response.data['Data']['o_password']);
        Get.toNamed(RouteHelper.changePassword);
      }

      // loginModel = LoginModel.fromMap(response.data);
      //  return loginModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return;
  }

  Future<GetClassesModel?> getClassesApi() async {
    try {
      GetClassesModel? getClassesModel;
      //var formData = FormData.fromMap({});
      var response = await dio.get(baseUrl + AppStrings.classesUrl);
      if (response.data['Status'] == true) {
        getClassesModel = GetClassesModel.fromMap(response.data);
        return getClassesModel;
      } else {
        Fluttertoast.showToast(msg: 'No classes found');
      }
      return getClassesModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetStreamsModel?> getStreamsApi({int? classId}) async {
    try {
      GetStreamsModel? getStreamsModel;
      //var formData = FormData.fromMap({});
      var response =
          await dio.get('${baseUrl + AppStrings.streamsUrl}?class_id=$classId');
      if (response.data['Status'] == true) {
        getStreamsModel = GetStreamsModel.fromMap(response.data);
        return getStreamsModel;
      } else {
        Fluttertoast.showToast(msg: 'No Streams found');
      }
      return getStreamsModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetSubjectModel?> getSubjectsApi({int? streamId}) async {
    try {
      GetSubjectModel? getSubjectModel;
      //var formData = FormData.fromMap({});
      var response = await dio
          .get('${baseUrl + AppStrings.subjectsUrl}?&stream_id=$streamId');
      getSubjectModel = GetSubjectModel.fromMap(response.data);

      return getSubjectModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetQuestionModel?> getQuestionsApi({int? topicId}) async {
    GetQuestionModel? getQuestionModel;

    try {
      //var formData = FormData.fromMap({});
      var response = await dio
          .get('${baseUrl + AppStrings.questionsUrl}?topic_id=$topicId');
      getQuestionModel = GetQuestionModel.fromMap(response.data);
      // getQuestionModel.data?.forEach((element1) {
      //   // getQuestionModel?.data?.forEach((element) {
      //   //   print('Bu ${element1.option1}');
      //   //   element.optionModel?.add(optionsModel(option1: element1.option1));
      //   //   print('MODel ${element.optionModel?[0].option1}');
      //   // });
      // });

      return getQuestionModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetQuestionResultModel?> getQuestionsResultApi(
      {int? topicId, int? studentId}) async {
    GetQuestionResultModel? getQuestionResultModel;

    try {
      //var formData = FormData.fromMap({});
      var response = await dio.get(
          '${baseUrl + AppStrings.saveAnswerUrl}?topic_id=$topicId&student_id=$studentId');
      getQuestionResultModel = GetQuestionResultModel.fromMap(response.data);

      return getQuestionResultModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }

    return null;
  }

  Future<GetTopicModel?> getTopicsApi({int? subjectId, int? type}) async {
    try {
      GetTopicModel? getTopicModel;
      // type == null ? dio.get(
      //     '${baseUrl + AppStrings.topicsUrl}?subjectId=$subjectId') : dio.get(
      //     '${baseUrl + AppStrings.topicsUrl}?subjectId=$subjectId&type=$type');
      var response = type == null
          ? await dio
              .get('${baseUrl + AppStrings.topicsUrl}?subject_id=$subjectId')
          : await dio.get(
              '${baseUrl + AppStrings.topicsUrl}?subject_id=$subjectId&type=$type');
      getTopicModel = GetTopicModel.fromMap(response.data);
      return getTopicModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetCategories?> getCategoriesApi() async {
    try {
      GetCategories? getCategories;
      // var formData = FormData.fromMap({});
      var response = await dio.get('${baseUrl + AppStrings.categoriesUrl}');
      log('categoriesUrl ${response.data}');
      log('categoriesUrl ${GetCategories.fromJson(response.data)}');
      getCategories = GetCategories.fromJson(response.data);
      log('$getCategories');
      return getCategories;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetCategories?> getQuestionsTopicApiApi({int? subjectId}) async {
    try {
      GetCategories? getCategories;
      // var formData = FormData.fromMap({});
      var response = await dio.get(
          '${baseUrl + AppStrings.topicsForQuestionsUrl}?subject_id=$subjectId');
      log('categoriesUrl ${response.data}');
      log('categoriesUrl ${GetCategories.fromJson(response.data)}');
      getCategories = GetCategories.fromJson(response.data);
      log('$getCategories');
      return getCategories;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetTransactionModel?> getTransactionApi(
      {String? parentCode, String? txnType}) async {
    try {
      GetTransactionModel? getTransactionModel;
      // var formData = FormData.fromMap({'parentCode': parentCode});
      var response = await dio.get(
          '${baseUrl + AppStrings.transactionsUrl}?parent_code=$parentCode&txn_type=$txnType');
      getTransactionModel = GetTransactionModel.fromMap(response.data);
      return getTransactionModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetEarningModel?> getEarningApi({String? parentCode}) async {
    try {
      GetEarningModel? getEarningModel;
      //var formData = FormData.fromMap({'parentCode': parentCode});
      var response = await dio
          .get('${baseUrl + AppStrings.earningUrl}?parent_code=$parentCode');
      getEarningModel = GetEarningModel.fromMap(response.data);
      return getEarningModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<MyReferralModel?> getReferralApi({String? referralCode}) async {
    MyReferralModel? myReferralModel;
    try {
      // var formData = FormData.fromMap({'referral_code': referral_code});
      var response = await dio.get(
          '${baseUrl + AppStrings.referralsUrl}?referral_code=$referralCode');
      if (response.data['Status'] == true) {
        myReferralModel = MyReferralModel.fromMap(response.data);
        return myReferralModel;
      }
      // else {
      //   myReferralModel?.data = [];
      // }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<GetSlider?> getSliderApi() async {
    GetSlider? getSlider;
    try {
      var response = await dio.get(baseUrl + AppStrings.slidesUrl);
      if (response.data['Status'] == true) {
        getSlider = GetSlider.fromJson(response.data);
        return getSlider;
      }
      // else {
      //   myReferralModel?.data = [];
      // }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  withdrawAmountApi(
      {String? parentCode,
      String? amount,
      String? mobileWithdraw,
      String? upi}) async {
    WithdawModel withdawModel = WithdawModel();
    try {
      var formData = FormData.fromMap({
        'parentCode': parentCode,
        'amount': amount,
        'mobile_withdraw': mobileWithdraw,
        'upi': upi,
      });
      var response = await dio.post(
        baseUrl + AppStrings.withdrawUrl,
        data: formData,
      );

      withdawModel = WithdawModel.fromMap(response.data);
      Fluttertoast.showToast(msg: response.data['Data']['message'] ?? '');
      if (withdawModel.status == true) {
        Get.toNamed(RouteHelper.congratsScreen);
      }
      return withdawModel;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  saveAnswerApi({
    int? studentId,
    int? questionId,
    String? studentAnswer,
    String? time,
  }) async {
    try {
      var formData = FormData.fromMap({
        'student_id': studentId,
        'question_id': questionId,
        'student_answer': studentAnswer,
        'time': DateTime.now()
      });
      await dio.post(
        baseUrl + AppStrings.saveAnswerUrl,
        data: formData,
      );
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  updateAnswerApi({
    int? studentId,
    int? questionId,
    String? studentAnswer,
    String? time,
  }) async {
    try {
      await dio.get('${baseUrl + AppStrings.updateAnswerUrl}'
          '?student_id=$studentId&question_id=$questionId&student_answer=$studentAnswer&time=${DateTime.now()}');
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
  }

  Future<Response?> buyPaymentApi(
      {String? studentId,
      String? amount,
      String? txnId,
      String? method,
      String? status,
      String? time}) async {
    try {
      var formData = FormData.fromMap({
        'student_id': studentId,
        'amount': amount,
        'txn_id': txnId,
        'method': method,
        'status': status,
        'time': time
      });

      var response = await dio.post(
        baseUrl + AppStrings.paymentUrl,
        data: formData,
      );

      SharedPrefClass.setString(
          AppStrings.myReferralCode, response.data['my_referral_code'] ?? ' ');

      // withdawModel = WithdawModel.fromMap(response.data);
      // Fluttertoast.showToast(msg: response.data['Data']['message'] ?? '');
      // if (withdawModel.status == true) {
      //   Get.toNamed(RouteHelper.congratsScreen);
      // }
      return response;
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: 'Check your Connection');
      throw SocketException(e.toString());
    } on DioError catch (e) {
      print('error $e');
      Fluttertoast.showToast(
          msg: 'Something went wrong please try again latter.');
      // Get.toNamed(RouteHelper.getPremiumMemberShip);
    }
    return null;
  }
}
