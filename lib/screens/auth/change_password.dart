import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  bool? loading;
  bool? oldPassword = true;
  bool? newpPassword = true;

  @override
  void initState() {
    oldPass.text = SharedPrefClass.getString(AppStrings.userPassword);
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
                                hintText: 'Old password',
                                obscureText: oldPassword,
                                suffixWidget: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        oldPassword = !oldPassword!;
                                      });
                                    },
                                    child: oldPassword == true
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(
                                            Icons.remove_red_eye_outlined)),
                                textInputType: TextInputType.text,
                                textEditingController: oldPass,
                                textInputAction: TextInputAction.next,
                                validator: FormValidation.emptyValidation(
                                    value: oldPass.text)),
                            SizedBox(
                              height: 2.h,
                            ),
                            AppWidgets.textFormFieldWidget(
                                hintText: 'New password',
                                obscureText: newpPassword,
                                suffixWidget: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        newpPassword = !newpPassword!;
                                      });
                                    },
                                    child: newpPassword == true
                                        ? const Icon(Icons.remove_red_eye)
                                        : const Icon(
                                            Icons.remove_red_eye_outlined)),
                                textInputType: TextInputType.text,
                                textEditingController: newPass,
                                textInputAction: TextInputAction.done,
                                validator: FormValidation.emptyValidation(
                                    value: newPass.text)),

                            SizedBox(
                              height: 4.h,
                            ),

                            AppWidgets.elevButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    ApiServices()
                                        .chnagePassApi(
                                            id: SharedPrefClass.getInt(
                                                AppStrings.id),
                                            oldPassword: oldPass.text,
                                            password: newPass.text)
                                        .then((value) {
                                      setState(() {
                                        loading = false;
                                      });
                                    });

                                    //Get.offAllNamed(RouteHelper.mainScreen);.
                                  }
                                },
                                text: AppStrings.changePassword),
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
