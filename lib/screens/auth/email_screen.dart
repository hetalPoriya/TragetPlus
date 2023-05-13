import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/auth/authentication_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/apiService/api_services.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  bool? loading;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    emailCon.text = SharedPrefClass.getString(AppStrings.eMail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.black)),
        ),
        extendBody: true,
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
                            Text(AppStrings.changePassword,
                                style: AppTextStyles.extraLargeTextStyle()
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3.h,
                            ),
                            AppWidgets.textFormFieldWidget(
                                hintText: 'Enter your email',
                                textInputType: TextInputType.emailAddress,
                                textEditingController: emailCon,
                                textInputAction: TextInputAction.done,
                                validator: FormValidation.emailValidation(
                                    value: emailCon.text)),
                            SizedBox(
                              height: 2.h,
                            ),

                            AppWidgets.elevButton(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    ApiServices()
                                        .getChangePasswordDetails(
                                            email: emailCon.text)
                                        .then((value) {
                                      setState(() {
                                        loading = false;
                                      });
                                    });

                                    //Get.offAllNamed(RouteHelper.mainScreen);.
                                  }
                                },
                                text: 'Submit'),
                            SizedBox(
                              height: 2.h,
                            ),
                            // AppWidgets.richTextWigdetForTermsAndCon(),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                          ],
                        ),
                      )),
                )),
            if (loading == true) AppWidgets.circularIndicator()
          ],
        ),
      ),
    );
  }
}
