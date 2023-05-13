import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: AppWidgets.titleText(text: 'Terms & Conditions'),
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
            AppWidgets.largeText(
                text: 'Terms & Conditions', decoration: TextDecoration.none),
            AppWidgets.smallSizedBox(),
            Image.asset(AppImages.learnEarn,
                height: 25.h, width: double.infinity, fit: BoxFit.fill),
            AppWidgets.smallSizedBox(),
            AppWidgets.largeText(text: 'Terms'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text:
                    'These Terms & Conditions (“Terms”) of use of our website '
                    'Learnify.co.in , our applications or any products or services in connection with '
                    'the Application . any modes of registrations or usage of products, including through'
                    ' SD cards, tablets or other storage/transmitting device are between Think & Learn '
                    'Private Limited and its use.'),
            AppWidgets.smallSizedBox(),
            AppWidgets.normalText(
                text:
                    'Please read the Terms and the privacy policy of the Company'
                    ' (“Privacy Policy”) with respect to registration with us, '
                    'the use of the Application, carefully before using the Application,'
                    ' In the event of any discrepancy between the Terms and any other policies with respect'
                    ' to the Application the provisions of the Terms shall prevail.Your use/access of the'
                    ' Application or registration (with payment/with subscription) through any mean shall '
                    'signify Your acceptance of the Terms and Your agreement to be legally bound by the same'),
            AppWidgets.smallSizedBox(),
            AppWidgets.largeText(text: 'Conditions'),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: '1. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text:
                          'Except as mentioned below, all information, content, material, trademarks,'
                          ' services marks, trade names, and trade secrets including but not limited'
                          ' to the software, text, images, graphics, video, script and audio, contained'
                          ' in the Application, Website, Services and products are proprietary property'
                          ' of the Company (“Proprietary Information”). No Proprietary Information may '
                          'be copied, downloaded, reproduced, modified, republished, uploaded, posted, '
                          'transmitted or distributed in any way without obtaining prior '
                          ' permission from the Company and nothing on this Application or Website or '
                          'Services shall be or products deemed to confer a license of or any other'
                          ' right, interest or title to or in any of the intellectual property rights'
                          ' belonging to the Company, to the User. You may own the medium on which the '
                          'information, content or materials resides, but the Company shall at all times'
                          ' retain full and complete title to the information, content or materials and '
                          'all intellectual property rights inserted by the Company on such medium. '
                          'Certain contents on the Website may belong to third parties.Such contents '
                          'have been reproduced after taking prior consent from said partyand all '
                          'rights relating to such content will remain with such third party.'
                          ' Further, you recognize and acknowledge that the ownership of all trademarks,'
                          ' copyright, logos, service marks and other intellectual property owned by'
                          ' any third party shall continue to vest with such party and You are not'
                          ' permitted to use the same without the consent of the respective third party.'),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: '2. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                    child: Column(
                  children: [
                    AppWidgets.normalText(
                        text:
                            'Your use of our products, Website, Application and Services is solely'
                            ' for Your personal and non-commercial use. Any use of the Application,'
                            ' Website, Services or products or their contents other than for'
                            ' personal purposes is prohibited. Your personal and non-commercial '
                            'use of this Application, Website, products and / or our Services shall '
                            'be subjected to the following restrictions:'),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidgets.normalText(text: 'i. '),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: AppWidgets.normalText(
                                text:
                                    'You may not decompile, reverse engineer, or disassemble '
                                    'the contents of the Application and / or our Website and/or Services/ products'
                                    ' or modify, copy, distribute, transmit, display, perform, reproduce, publish,'
                                    ' license, create derivative works from, transfer, or sell any information or software '
                                    'obtained from the Application and / or our Website and/or Services/products, or remove'
                                    ' any copyright, trademark registration, or other proprietary notices from the contents'
                                    ' of the Application and / or and / or our Website and/or Services/products.'))
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidgets.normalText(text: 'ii. '),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: AppWidgets.normalText(
                                text:
                                    'You will not (a) use this Application and / or our Website and/or any of'
                                    ' our product/s or Service/s for commercial purposes of any kind, or '
                                    '(b) advertise or sell the Application or any products, Services or domain'
                                    ' names or otherwise (whether or not for profit), or solicit others'
                                    ' (including, without limitation, solicitations for contributions or donations)'
                                    ' or use any public forum for commercial purposes of any kind, or (c) use the'
                                    ' Application and / or Website/our products and Services in any way that is '
                                    'unlawful, or harms the Company or any other person or entity as determined '
                                    'by the Company'))
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidgets.normalText(text: 'iii. '),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: AppWidgets.normalText(
                                text:
                                    'No User shall be permitted to perform any of the following prohibited '
                                    'activities while availing our Services:'))
                      ],
                    ),
                  ],
                ))
              ],
            ),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: 'a. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text: 'Making available any content that is misleading,'
                          ' unlawful, harmful, threatening, abusive, tortious, '
                          'defamatory, libelous, vulgar, obscene, child-pornographic,'
                          ' lewd, lascivious, profane, invasive of another\'s privacy,'
                          ' hateful, or racially, ethnically otherwise objectionable'),
                )
              ],
            ),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: 'b. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text:
                          'Stalking, intimidating and/or harassing another and/or '
                          'inciting other to commitviolence'),
                )
              ],
            ),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: 'c. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text:
                          'Transmitting material that encourages anyone to commit a criminal offence, '
                          'that results in civil liability or otherwise breaches any relevant laws,'
                          ' regulations or code of practice'),
                )
              ],
            ),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: 'd. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text:
                          'Interfering with any other person\'s use or enjoyment of the'
                          ' Application/Website/Services'),
                )
              ],
            ),
            AppWidgets.smallSizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppWidgets.normalText(text: 'e. '),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: AppWidgets.normalText(
                      text:
                          'Making, transmitting or storing electronic copies of materials protected'
                          ' by copyright without the permission of the owner, committing any '
                          'act that amounts to the infringement of intellectual property or'
                          ' making available any material that infringes any intellectual property'
                          ' rights or other proprietary rights of anyone else'),
                )
              ],
            ),
            AppWidgets.smallSizedBox(),
          ],
        ),
      )),
    ));
  }
}
