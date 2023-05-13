import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class YourEarning extends StatefulWidget {
  const YourEarning({Key? key}) : super(key: key);

  @override
  State<YourEarning> createState() => _YourEarningState();
}

class _YourEarningState extends State<YourEarning> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  GetEarningModel? getEarningModel;
  bool? loading;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getAllDataBloc.add(OnPressedGetEarningEvent(
        parentCode: SharedPrefClass.getString(AppStrings.myReferralCode)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: AppWidgets.appBarWithImage(
          appBarWidget: AppWidgets.appBarWidget(),
          middleCardWidget: BlocConsumer<GetAllDataBloc, GetAllDataState>(
            listener: ((context, state) {
              if (state is GetAllDataInitial) {
                setState(() {
                  loading = state.loading;
                });
              } else if (state is GetEarningLoaded) {
                setState(() {
                  getEarningModel = state.getEarningModel;
                });
              }
            }),
            builder: ((context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Material(
                  borderRadius: BorderRadius.circular(6.w),
                  elevation: 4,
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
                    child: loading == true
                        ? AppWidgets.circularIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Flexible(
                                  child: Text(
                                    'Your Earning',
                                    style: AppTextStyles.boldStyle(),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                AppWidgets.earningRow(
                                    text: 'Today Earning',
                                    amount: getEarningModel?.data?[0].todayCr ==
                                            null
                                        ? '0'
                                        : getEarningModel?.data?[0].todayCr
                                            .toString()),
                                AppWidgets.earningRow(
                                    text: 'Total Earning',
                                    amount: getEarningModel?.data?[0].totalCr ==
                                            null
                                        ? '0'
                                        : getEarningModel?.data?[0].totalCr
                                            .toString()),
                                AppWidgets.earningRow(
                                    text: 'Withdraw Amount',
                                    amount: getEarningModel?.data?[0].totalDr ==
                                            null
                                        ? '0'
                                        : getEarningModel?.data?[0].totalDr
                                                .toString() ??
                                            0.toString()),
                                AppWidgets.earningRow(
                                    text: 'Balance Wallet',
                                    amount: getEarningModel
                                                ?.data?[0].walletBalance ==
                                            null
                                        ? '0'
                                        : getEarningModel
                                            ?.data?[0].walletBalance
                                            .toString()),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () => Get.toNamed(
                                      RouteHelper.withdrawDoneScreen,
                                      arguments: [
                                        getEarningModel?.data?[0].walletBalance
                                            .toString()
                                      ]),
                                  child: Container(
                                    width: 40.w,
                                    height: 6.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.w),
                                        gradient: LinearGradient(colors: [
                                          AppColors.darkOrange,
                                          AppColors.lightOrange
                                        ])),
                                    child: Text('Withdraw',
                                        style: AppTextStyles.mediumTextStyle()),
                                  ),
                                )
                              ]),
                  ),
                ),
              );
            }),
          )),
    ));
  }
}
