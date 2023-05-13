import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/auth/authentication_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  bool? loading;
  bool showPassword= true;
  @override
  void initState() {
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
                            Text(AppStrings.signIn,
                                style: AppTextStyles.extraLargeTextStyle()
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3.h,
                            ),
                            AppWidgets.textFormFieldWidget(
                                hintText:
                                    '${AppStrings.eMail}/${AppStrings.mobileNumber}',
                                textInputType: TextInputType.text,
                                textEditingController: nameCon,
                                validator: (value) {
                                  if (!GetUtils.isEmail(value.toString()) &&
                                      value?.length != 10) {
                                    return 'Please enter a valid email or phone number.';
                                  }
                                  return null;
                                }),
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
                                validator: FormValidation.emptyValidation(
                                    value: passCon.text)),
                            SizedBox(
                              height: 1.h,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () =>
                                      Get.toNamed(RouteHelper.emailScreen),
                                  child: Text(
                                    'Forgot password',
                                    style: AppTextStyles.extraSmallTextStyle()
                                        .copyWith(color: Colors.black),
                                  )),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            AppWidgets.elevButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    authenticationBloc.add(OnLoginButtonPressed(
                                        username: nameCon.text,
                                        password: passCon.text));

                                    //Get.offAllNamed(RouteHelper.mainScreen);.
                                  }
                                },
                                text: AppStrings.signIn),
                            SizedBox(
                              height: 2.h,
                            ),
                            // AppWidgets.richTextWigdetForTermsAndCon(),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            AppWidgets.richTextWidgetForAlreadyHaveAcc(
                                accountOrNot: AppStrings.notAccount,
                                signUpOrIn: AppStrings.signUp,
                                onTap: () =>
                                    Get.toNamed(RouteHelper.registerScreen)),
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
