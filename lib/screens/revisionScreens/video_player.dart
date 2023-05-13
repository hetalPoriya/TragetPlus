import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/utils.dart';

class VideoPlayerScreen extends StatefulWidget {
  final dynamic argumentData = Get.arguments;
  // final String url;
  // final String desc;
  // String? value;
  VideoPlayerScreen({
    Key? key,
    // required this.url,
    // required this.desc,
    // this.value,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  final bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(Get.arguments[0]['url']) ?? '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return Stack(
              children: [
                ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player,
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              Get.arguments[1]['title'],
                              style: AppTextStyles.boldStyle()
                                  .copyWith(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              Get.arguments[2]['desc'],
                              //
                              // 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
                              // 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
                              // 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
                              // 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',

                              style: AppTextStyles.extraSmallTextStyle()
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        )),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    _controller.pause();
                    _controller.dispose();

                    Get.offNamed(RouteHelper.subjectVideo,
                        arguments: [Get.arguments[3], Get.arguments[4]]);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.lightOrange,
                  ),
                ),
              ],
            );
          },
        )));
  }
}
