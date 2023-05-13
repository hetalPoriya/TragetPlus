import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/auth/authentication_bloc.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/apiService/api_services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController mobileNumberCon = TextEditingController();
  TextEditingController paymentNumberCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController upiCon = TextEditingController();

  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  bool? loading;
  String userData = '';

  getMyData() async {
    userData = await SharedPrefClass.getUserData();

    Map<String, dynamic> data = jsonDecode(userData);
    mobileNumberCon.text = data['mobile'];
    emailCon.text = data['email'];

    nameCon.text = SharedPrefClass.getString(AppStrings.studentName);
    addressCon.text = SharedPrefClass.getString(AppStrings.userAdd);
    upiCon.text = SharedPrefClass.getString(AppStrings.userUpi);
    paymentNumberCon.text =
        SharedPrefClass.getString(AppStrings.userPaymentNumber);
  }

  @override
  void initState() {
    getMyData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ))),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 3.h),
                          Text(
                            'Edit Profile',
                            style: AppTextStyles.extraLargeTextStyle().copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                              hintText: AppStrings.name,
                              lableText: AppStrings.name,
                              textInputType: TextInputType.text,
                              textEditingController: nameCon,
                              textInputAction: TextInputAction.next,
                              validator: FormValidation.nameValidation(
                                  value: nameCon.text)),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                            hintText: AppStrings.eMail,
                            lableText: AppStrings.eMail,
                            readOnly: true,
                            textEditingController: emailCon,
                            textInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                            hintText: AppStrings.mobileNumber,
                            lableText: AppStrings.mobileNumber,
                            textInputType: TextInputType.number,
                            textEditingController: mobileNumberCon,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                              hintText: AppStrings.address,
                              lableText: AppStrings.address,
                              textInputType: TextInputType.text,
                              textEditingController: addressCon,
                              textInputAction: TextInputAction.next,
                              validator: FormValidation.addressValidation(
                                  value: addressCon.text)),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                              hintText: 'Enter your upi',
                              lableText: 'Your upi',
                              textInputType: TextInputType.text,
                              textEditingController: upiCon,
                              textInputAction: TextInputAction.next,
                              validator: upiCon.text.isNotEmpty == true
                                  ? FormValidation.addressValidation(
                                      value: upiCon.text)
                                  : (a) {
                                      return null;
                                    }),
                          SizedBox(
                            height: 2.h,
                          ),
                          AppWidgets.editProfileTextFormFieldWidget(
                              hintText:
                                  'Enter your phone no. to receive your earning',
                              lableText:
                                  'Enter your phone no. to receive your earning',
                              textInputType: TextInputType.text,
                              textEditingController: paymentNumberCon,
                              textInputAction: TextInputAction.done,
                              validator:
                                  paymentNumberCon.text.isNotEmpty == true
                                      ? FormValidation.mobileNumberValidation(
                                          value: paymentNumberCon.text)
                                      : (a) {
                                          return null;
                                        }),
                          SizedBox(
                            height: 4.h,
                          ),
                          AppWidgets.elevButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  SharedPrefClass.setString(
                                      AppStrings.userAdd, addressCon.text);
                                  SharedPrefClass.setString(
                                      AppStrings.studentName, nameCon.text);
                                  SharedPrefClass.setString(
                                      AppStrings.userUpi, upiCon.text);
                                  SharedPrefClass.setString(
                                      AppStrings.userPaymentNumber,
                                      paymentNumberCon.text);
                                  ApiServices()
                                      .updateProfileApi(
                                          id: SharedPrefClass.getInt(
                                              AppStrings.id),
                                          address: addressCon.text,
                                          username: nameCon.text,
                                          upi: upiCon.text,
                                          mobileWithdraw: paymentNumberCon.text)
                                      .then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                  // authenticationBloc.add(onSignUpButtonPressed(
                                  //     loginModel: LoginModel(
                                  //   name: nameCon.text,
                                  //   address: addressCon.text,
                                  //   email: emailCon.text,
                                  //   mobile: mobileNumberCon.text,
                                  // )));
                                  //Fluttertoast.showToast(msg: 'Success');
                                }
                              },
                              text: 'Edit'),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    )),
              )),
          if (loading == true) AppWidgets.circularIndicator()
        ],
      ),
    ));
  }
}
