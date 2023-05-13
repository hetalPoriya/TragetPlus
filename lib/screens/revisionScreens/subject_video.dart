import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';

class SubjectVideos extends StatefulWidget {
  const SubjectVideos({Key? key}) : super(key: key);

  @override
  State<SubjectVideos> createState() => _SubjectVideosState();
}

class _SubjectVideosState extends State<SubjectVideos> {
  bool? loading = true;
  String? topicName;
  List<GetTopicsList> getTopicList = [];

  // bool? loadingPdf = false;

  @override
  void initState() {
    topicName = Get.arguments[0];

    log(topicName.toString());
    getTopicList = Get.arguments[1];
    log(getTopicList.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AppWidgets.fullRect(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidgets.appBarWidget(
                            onTapOnBackButton: () => Get.back()),
                        SizedBox(
                          height: 1.h,
                        ),
                        AppWidgets.appBarWidgetForRevision(
                            subjectName: SharedPrefClass.getString(
                              AppStrings.subjectName,
                            ),
                            topicName: 'Videos'),
                      ],
                    )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      child: Text(
                        'Videos',
                        style: AppTextStyles.largeTextStyle().copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkOrange,
                            decoration: TextDecoration.underline,
                            letterSpacing: 1,
                            decorationThickness: 2),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    (getTopicList.isEmpty || getTopicList == [])
                        ? Container(
                            height: 70.h,
                            alignment: Alignment.center,
                            child: Text(
                              'No Data Found',
                              style: AppTextStyles.smallTextStyle()
                                  .copyWith(color: Colors.black),
                            ))
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                            ),
                            child: GridView.builder(
                                itemCount: getTopicList.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                      onTap: () => Get.toNamed(
                                              RouteHelper.videoPlayerScreen,
                                              arguments: [
                                                {
                                                  'url':
                                                      getTopicList[index].size
                                                },
                                                {
                                                  'title':
                                                      getTopicList[index].name
                                                },
                                                {
                                                  'desc':
                                                      getTopicList[index].file
                                                },
                                                topicName,
                                                getTopicList,
                                              ]),
                                      child: Material(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          elevation: 4.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.red,
                                                          image: DecorationImage(
                                                              image: NetworkImage(YoutubePlayer.getThumbnail(
                                                                  videoId: YoutubePlayer.convertUrlToId(
                                                                      getTopicList[
                                                                              index]
                                                                          .size
                                                                          .toString())!)),
                                                              fit:
                                                                  BoxFit.fill)),
                                                      child: Icon(
                                                          Icons
                                                              .play_circle_fill_outlined,
                                                          color: Colors.white,
                                                          size: 15.w),
                                                    )),
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        getTopicList[index]
                                                            .name
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                                .extraSmallTextStyle()
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )));
                                })),
                          ),
                  ],
                ))));
  }
}
