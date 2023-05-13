import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/auth/authentication_bloc.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class ClassesModel {
  int? id;
  String? name;

  ClassesModel({this.name, this.id});
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController mobileNumberCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController referredCodeCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  bool? loading;
  bool showPassword = true;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: ((context, state) {
                      if (state is AuthenticationInitial) {
                        setState(() {
                          loading = state.loading;
                        });
                      }
                    }),
                    child: SingleChildScrollView(
                      child: Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 3.h),
                                Text(AppStrings.createAccount,
                                    style: AppTextStyles.extraLargeTextStyle()
                                        .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 3.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText: AppStrings.name,
                                    textInputType: TextInputType.text,
                                    textEditingController: nameCon,
                                    validator: FormValidation.nameValidation(
                                        value: nameCon.text)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText: AppStrings.eMail,
                                    textInputType: TextInputType.emailAddress,
                                    textEditingController: emailCon,
                                    validator: FormValidation.emailValidation(
                                        value: emailCon.text)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText:
                                    '${AppStrings.mobileNumber} ex:9876543210',
                                    textInputType: TextInputType.number,
                                    textEditingController: mobileNumberCon,
                                    validator:
                                    FormValidation.mobileNumberValidation(
                                        value: mobileNumberCon.text)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText: AppStrings.address,
                                    textInputType: TextInputType.text,
                                    textEditingController: addressCon,
                                    validator: FormValidation.addressValidation(
                                        value: addressCon.text)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText: AppStrings.referredCode,
                                    textInputType: TextInputType.text,
                                    textEditingController: referredCodeCon,
                                    validator: FormValidation
                                        .referralValidation(
                                        value: referredCodeCon.text)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.textFormFieldWidget(
                                    hintText: AppStrings.password,
                                    textInputType: TextInputType.text,
                                    textEditingController: passCon,
                                    obscureText: showPassword,
                                    suffixWidget: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Icon(
                                          showPassword == false
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.remove_red_eye,
                                          color: AppColors.lightOrange),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    validator: FormValidation
                                        .passwordValidation(
                                        value: passCon.text)),
                                SizedBox(
                                  height: 4.h,
                                ),
                                AppWidgets.elevButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        authenticationBloc
                                            .add(OnSignUpButtonPressed(
                                            loginModel: LoginModel(
                                              name: nameCon.text,
                                              password: passCon.text,
                                              address: addressCon.text,
                                              email: emailCon.text,
                                              mobile: mobileNumberCon.text,
                                              referralCode: referredCodeCon
                                                  .text,
                                            )));
                                        //Fluttertoast.showToast(msg: 'Success');
                                      }
                                    },
                                    text: AppStrings.signUp),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.richTextWigdetForTermsAndCon(),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppWidgets.richTextWidgetForAlreadyHaveAcc(
                                    accountOrNot: AppStrings.alreadyAccount,
                                    signUpOrIn: AppStrings.signIn,
                                    onTap: () =>
                                        Get.offNamed(RouteHelper.signIn)),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          )),
                    ),
                  )),
              if (loading == true) AppWidgets.circularIndicator()
            ],
          ),
        ));
  }
}
