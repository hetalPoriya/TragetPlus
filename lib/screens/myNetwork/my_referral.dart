import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';
import 'package:traget_plus/models/models.dart';

class MyReferrals extends StatefulWidget {
  const MyReferrals({Key? key}) : super(key: key);

  @override
  State<MyReferrals> createState() => _MyReferralsState();
}

class _MyReferralsState extends State<MyReferrals> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  bool? loading;
  MyReferralModel? myReferralModel;
  List<MyReferralData>? myReferralData = [];
  List<MyReferralData>? innerData = [];
  final ScrollController controller = ScrollController();
  int lastIndex = 0;
  List<String> referralList = [];
  String? myRefferal;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getAllDataBloc.add(OnPressedGetReferralEvent(
        referralCode: SharedPrefClass.getString(AppStrings.myReferralCode)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocConsumer<GetAllDataBloc, GetAllDataState>(
        listener: ((context, state) {
          if (state is GetAllDataInitial) {
            setState(() {
              loading = state.loading;
            });
          } else if (state is GetReferralLoaded) {
            setState(() {
              myReferralModel = state.myReferralModel;
              myReferralData = state.myReferralModel?.data;
              // var colors2 =
              //     TreeNodeData(label: myReferralModel!.data![0].email.toString());
              // _controller.treeData([colors2]);
            });
          }
        }),
        builder: ((context, state) {
          return ListView(children: [
            AppWidgets.fullRect(
                height: 26.h,
                child: Column(
                  children: [
                    AppWidgets.appBarWidget(),
                    AppWidgets.userInfo(),
                  ],
                )),
            SizedBox(
              height: 4.h,
            ),
            Center(
              child: Text(
                'My Referals',
                style: AppTextStyles.boldStyle(),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            if (referralList.isNotEmpty)
              Container(
                height: 4.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView.builder(
                    itemCount: referralList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          getAllDataBloc.add(OnPressedGetReferralEvent(
                              referralCode:
                                  referralList[index].split('-').last));
                          setState(() {
                            referralList.removeRange(
                                index, referralList.length);
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              referralList[index],
                              style:
                                  AppTextStyles.extraSmallTextStyle().copyWith(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: null,
                            ),
                            Text(
                              ' > ',
                              style: AppTextStyles.smallTextStyle().copyWith(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: null,
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            if (referralList.isNotEmpty)
              SizedBox(
                height: 2.h,
              ),
            loading == true
                ? AppWidgets.circularIndicator()
                : myReferralData!.isNotEmpty
                    ? ListView.builder(
                        itemCount: myReferralData?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                if (myReferralData![index].direct != 0) {
                                  referralList.add(
                                      '${myReferralData![index].name}-${myReferralData![index].myReferralCode}');

                                  getAllDataBloc.add(OnPressedGetReferralEvent(
                                      referralCode: myReferralData![index]
                                          .myReferralCode));
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'There is no other referral students');
                                }
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                myReferralData![index]
                                                    .name
                                                    .toString(),
                                                style: AppTextStyles
                                                        .smallTextStyle()
                                                    .copyWith(
                                                        color: Colors.black)),
                                            // Text(
                                            //     myReferralData![index]
                                            //         .email
                                            //         .toString(),
                                            //     style: AppTextStyles
                                            //             .smallTextStyle()
                                            //         .copyWith(
                                            //             color: Colors
                                            //                 .black)),
                                            Text(
                                                myReferralData![index]
                                                    .myReferralCode
                                                    .toString(),
                                                style: AppTextStyles
                                                        .smallTextStyle()
                                                    .copyWith(
                                                        color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      Text(myReferralData![index]
                                          .direct
                                          .toString()),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: AppColors.darkGrey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
                    : Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                              'No Data Found',
                              style: AppTextStyles.smallTextStyle()
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )
          ]);
        }),
      ),
    )));
  }
}
