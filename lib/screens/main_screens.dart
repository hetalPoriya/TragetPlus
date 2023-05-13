import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  GetClassesModel? getClassesModel;
  List<GetSliderList>? getSlider = [];
  List<GetSliderList>? getVideo = [];
  bool? loading;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of(context);
    getAllDataBloc.add(OnPressedGetClassesEvent());
    getAllDataBloc.add(OnPressedGetSliderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: AppWidgets.drawerWidget(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<GetAllDataBloc, GetAllDataState>(
          listener: ((context, state) {
            if (state is GetAllDataInitial) {
              setState(() {
                loading = state.loading;
              });
            }
            if (state is GetClassesLoaded) {
              setState(() {
                getClassesModel = state.getClassesModel;
              });
            }

            if (state is GetSliderLoaded) {
              getSlider = [];
              getVideo = [];
              for (int i = 0; i < state.getSliders!.data.length; i++) {
                if (state.getSliders!.data[i].type == 0) {
                  getSlider!.add(state.getSliders!.data[i]);
                  setState(() {});
                } else {
                  getVideo!.add(state.getSliders!.data[i]);
                  setState(() {});
                }
              }
            }
          }),
          builder: ((context, state) {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: OrientationBuilder(builder: ((context1, orientation) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 33.h,
                          child: Stack(children: [
                            Container(
                              height: 22.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.fullRect),
                                      fit: BoxFit.fill)
                                  //     gradient: LinearGradient(colors: [
                                  //   AppColors.boxColor1,
                                  //   AppColors.boxColor2,
                                  // ])
                                  ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                    width: double.infinity,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                alignment: Alignment.topRight,
                                                image: AssetImage(
                                                    AppImages.halfCircle))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  height: 6.h,
                                                  width: 14.w,
                                                  child: GestureDetector(
                                                    onTap: () => scaffoldKey
                                                        .currentState
                                                        ?.openDrawer(),
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: Colors.white,
                                                      size: 10.w,
                                                    ),
                                                  ),
                                                  // decoration: BoxDecoration(
                                                  //     color: Colors.white,
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             4.w),
                                                  //     image: DecorationImage(
                                                  //         image: AssetImage(
                                                  //       AppImages
                                                  //           .targetPlusLogo,
                                                  //     ))),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Text(
                                                AppStrings.learningApp,
                                                style: AppTextStyles
                                                    .mediumTextStyle(),
                                              )),
                                              SharedPrefClass.getBool(
                                                          AppStrings.isLogin,
                                                          false) ==
                                                      true
                                                  ? Expanded(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Flexible(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () =>
                                                                    Get.toNamed(
                                                                        RouteHelper
                                                                            .notificationScreen),
                                                                child: const Icon(
                                                                    Icons
                                                                        .notifications_none,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            // SizedBox(
                                                            //   width: 6.w,
                                                            // ),
                                                            // Flexible(
                                                            //   child:
                                                            //       GestureDetector(
                                                            //     onTap: () {},
                                                            //     child: Icon(
                                                            //         Icons
                                                            //             .message_rounded,
                                                            //         color: Colors
                                                            //             .white),
                                                            //   ),
                                                            // ),
                                                            SizedBox(
                                                              width: 6.w,
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () =>
                                                                    showDialogForLogOut(),
                                                                child: const Icon(
                                                                    Icons
                                                                        .logout,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                          ]),
                                                    )
                                                  : Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: TextButton(
                                                            onPressed: () =>
                                                                Get.toNamed(
                                                                    RouteHelper
                                                                        .signIn),
                                                            child: Text(
                                                              'Log in',
                                                              style: AppTextStyles
                                                                      .smallTextStyle()
                                                                  .copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            )),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: CarouselSlider.builder(
                                itemCount: getSlider?.length,
                                options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    autoPlay: false,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    initialPage: 0,
                                    viewportFraction: 0.8),
                                itemBuilder: (context, index, realIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: orientation == Orientation.portrait
                                            ? 4.h
                                            : 10.h),
                                    child: Container(
                                      width: double.infinity,
                                      height: orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.height *
                                              0.20
                                          : MediaQuery.of(context).size.height *
                                              0.30,
                                      decoration: BoxDecoration(
                                          color: Colors.black45,
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              onError: (e, s) {},
                                              image: NetworkImage(getSlider!
                                                      .isEmpty
                                                  ? ''
                                                  : 'https://targetplus.co.in/chd/storage/app/${getSlider?[index].slide}'))),
                                    ),
                                  );
                                },
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height:
                              orientation == Orientation.portrait ? 5.h : 2.h,
                        ),
                        Center(
                          child: Text(AppStrings.learningAndEarning,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.boldStyle()
                                  .copyWith(fontSize: 16.sp)),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        (getClassesModel?.data == null && getVideo == null)
                            ? AppWidgets.circularIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            orientation == Orientation.portrait
                                                ? 4.w
                                                : 12.w,
                                        right:
                                            orientation == Orientation.portrait
                                                ? 4.w
                                                : 12.w),
                                    child: getClassesModel?.data == null
                                        ? AppWidgets.circularIndicator()
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                getClassesModel?.data?.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 2.w,
                                                    crossAxisSpacing: 4.w,
                                                    childAspectRatio: 3),
                                            itemBuilder: ((context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  if (SharedPrefClass.getBool(
                                                          AppStrings.isLogin,
                                                          false) ==
                                                      true) {
                                                    if (SharedPrefClass.getInt(
                                                            AppStrings
                                                                .isPremium) ==
                                                        1) {
                                                      SharedPrefClass.setInt(
                                                          AppStrings.classId,
                                                          getClassesModel!
                                                              .data![index]
                                                              .id!);
                                                      SharedPrefClass.setInt(
                                                          AppStrings.streamId,
                                                          int.parse(
                                                              getClassesModel!
                                                                  .data![index]
                                                                  .streams
                                                                  .toString()));
                                                      SharedPrefClass.setString(
                                                          AppStrings
                                                              .selectClass,
                                                          getClassesModel!
                                                              .data![index].name
                                                              .toString());
                                                      setState(() {});
                                                      Get.offNamedUntil(
                                                          RouteHelper
                                                              .subjectScreen,
                                                          (route) => false);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Please enroll first to access premium content');
                                                      Get.toNamed(RouteHelper
                                                          .getPremiumMemberShip);
                                                    }
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Please login or signUp first');
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.w),
                                                      gradient: LinearGradient(
                                                          colors:
                                                              // (SharedPrefClass.getBool(
                                                              //                 AppStrings
                                                              //                     .isLogin,
                                                              //                 false) ==
                                                              //             true &&
                                                              //         SharedPrefClass.getString(
                                                              //                 AppStrings
                                                              //                     .selectClass) !=
                                                              //             getClassesModel!
                                                              //                 .data![
                                                              //                     index]
                                                              //                 .name
                                                              //                 .toString())
                                                              //     ? [
                                                              //         Colors.black26,
                                                              //         Colors.black26,
                                                              //       ]
                                                              //     :
                                                              index % 6 == 0
                                                                  ? AppUtils
                                                                          .colorsList[
                                                                      0]
                                                                  : index % 6 ==
                                                                          1
                                                                      ? AppUtils
                                                                              .colorsList[
                                                                          1]
                                                                      : index % 6 ==
                                                                              2
                                                                          ? AppUtils
                                                                              .colorsList[2]
                                                                          : index % 6 == 3
                                                                              ? AppUtils.colorsList[3]
                                                                              : index % 6 == 4
                                                                                  ? AppUtils.colorsList[4]
                                                                                  : AppUtils.colorsList[5])),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.w),
                                                            child: Text(
                                                              getClassesModel!
                                                                  .data![index]
                                                                  .name
                                                                  .toString(),
                                                              // getClassesModel!
                                                              //             .data![
                                                              //                 index]
                                                              //             .name
                                                              //             .toString() ==
                                                              //         'COMPETITION'
                                                              //     ? getClassesModel!
                                                              //         .data![
                                                              //             index]
                                                              //         .name
                                                              //         .toString()
                                                              //     : '${getClassesModel!.data![index].name.toString()}th',
                                                              style: getClassesModel!
                                                                          .data![
                                                                              index]
                                                                          .name
                                                                          .toString() ==
                                                                      'COMPETITION'
                                                                  ? AppTextStyles
                                                                      .smallTextStyle()
                                                                  : AppTextStyles
                                                                      .mediumTextStyle(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Icon(
                                                              SharedPrefClass.getInt(
                                                                          AppStrings
                                                                              .isPremium) ==
                                                                      1
                                                                  ? Icons.done
                                                                  : Icons.lock,
                                                              color: SharedPrefClass.getInt(
                                                                          AppStrings
                                                                              .isPremium) ==
                                                                      1
                                                                  ? AppColors
                                                                      .darkGreen
                                                                  : Colors.red),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            orientation == Orientation.portrait
                                                ? 6.w
                                                : 14.w,
                                        right:
                                            orientation == Orientation.portrait
                                                ? 4.w
                                                : 12.w),
                                    child: Text(
                                      'Our Videos',
                                      style: AppTextStyles.smallTextStyle()
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  getVideo == null
                                      ? AppWidgets.circularIndicator()
                                      : SizedBox(
                                          //color: Colors.red,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: orientation ==
                                                  Orientation.portrait
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15
                                              : MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.40,
                                          child: ListView.builder(
                                            itemCount: getVideo?.length,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  left: 6.w,
                                                  // right: index == 3 ? 6.w : 1.w
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        RouteHelper
                                                            .videoPlayerScreen,
                                                        arguments: [
                                                          {
                                                            'url':
                                                                getVideo?[index]
                                                                    .slide
                                                          },
                                                          {'title': ''},
                                                          {'desc': ''},
                                                        ]);
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .50,
                                                    height: orientation ==
                                                            Orientation.portrait
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.red,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                YoutubePlayer.getThumbnail(
                                                                    videoId: YoutubePlayer.convertUrlToId(getVideo![
                                                                            index]
                                                                        .slide
                                                                        .toString())!)),
                                                            fit: BoxFit.fill)),
                                                    child: Icon(
                                                        Icons
                                                            .play_circle_fill_outlined,
                                                        color: Colors.white,
                                                        size: 15.w),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  if (SharedPrefClass.getInt(
                                          AppStrings.isPremium) !=
                                      1) ...[
                                    if (getClassesModel?.data != null)
                                      Text(
                                          'To access premium course material, click , pay and get membership.',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles
                                                  .extraSmallTextStyle()
                                              .copyWith(color: Colors.grey)),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    if (getClassesModel?.data != null)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: AppWidgets.elevButton(
                                            onTap: () {
                                              if (SharedPrefClass.getBool(
                                                      AppStrings.isLogin,
                                                      false) ==
                                                  false) {
                                                Get.toNamed(RouteHelper.signIn);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getPremiumMemberShip);
                                              }
                                            },
                                            text: 'Get Premium Membership '),
                                      ),
                                  ],
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              )
                      ],
                    ),
                  );
                })));
          }),
        ),
      ),
    ));
  }

  showDialogForLogOut() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.boxColor1,
          title: Text('Logout', style: AppTextStyles.mediumTextStyle()),
          content: Text(AppStrings.logOutOrNot,
              style: AppTextStyles.smallTextStyle()),
          actions: [
            TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'No',
                  style: AppTextStyles.smallTextStyle(),
                )),
            TextButton(
                onPressed: () {
                  Get.back();
                  SharedPrefClass.setBool(AppStrings.isLogin, false);
                  Get.offNamedUntil(RouteHelper.signIn, (route) => false);
                },
                child: Text(
                  'Yes',
                  style: AppTextStyles.smallTextStyle(),
                )),
          ],
        );
      },
    );
  }
}
