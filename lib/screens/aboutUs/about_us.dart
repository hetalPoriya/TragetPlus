import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: AppWidgets.titleText(text: 'ABOUT US'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppWidgets.smallSizedBox(),
            AppWidgets.titleText(text: 'ABOUT US'),
            AppWidgets.smallSizedBox(),
            AppWidgets.titleText(text: 'Our Mission'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text: '‘Make Learning and earning personalized ‘.'),
            AppWidgets.smallSizedBox(),
            AppWidgets.titleText(text: 'WHY WE ARE HERE,'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text:
                    'At Learnify , students are at the centre of our universe. We believe that '
                    'every student is different and has different learning needs and also having '
                    'the issue of earning for their daily basis . We work continuously to solve student'
                    ' problems using advanced technology and help them learn bettered also giving the'
                    ' platform for earning . We have thoughtfully designed Learnify to ensure that '
                    'it is a one step after-school learning and other also giving the earning platform. '
                    'it including adaptive practice questions, solutions, concepts, videos and '
                    'personalised notes that come together seamlessly to give 360° learning. '
                    'We use virtual based self learning programme , to create personalised learning'
                    ' paths for millions of students. We are just not giving the learning also the '
                    'self earning with your studying'),
            AppWidgets.smallSizedBox(),
            AppWidgets.titleText(text: 'LEARNING STATUS'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text:
                    'We are giving the learning personalized by providing the personal notes and '
                    'virtual animated video , test series , objective questions , sample paper for 6 to 12 and '
                    'for competition levels.'),
            AppWidgets.smallSizedBox(),
            AppWidgets.titleText(text: 'EARNING STATUS'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text:
                    'We are also giving the earning platform to fulfill desire'
                    ' needs of a student . student join their friends and relatives for learning and'
                    ' earning purpose and enjoy their student life with fun of learning by the animated'
                    ' videos of academic etc.'),
            AppWidgets.smallSizedBox(),
          ],
        ),
      )),
    ));
  }
}
