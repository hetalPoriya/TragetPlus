import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

import '../../models/models.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  bool? loading;
  GetTransactionModel? getTransactionModel;
  @override
  void initState() {
    // print(
    //     'SharedPrefClass.getString(AppStrings.myReferralCode) ${SharedPrefClass.getString(AppStrings.myReferralCodeUser)}');
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    getAllDataBloc.add(OnPressedGetTransactiOnEvent(
        parentCode: SharedPrefClass.getString(AppStrings.myReferralCode),
        txnType: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
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
                        'Transaction History',
                        style: AppTextStyles.boldStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: const Divider(
                        thickness: 2,
                      ),
                    ),
                    DefaultTabController(
                        length: 3, // length of tabs
                        initialIndex: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 5.h,
                                  child: TabBar(
                                    labelColor: Colors.white,
                                    indicatorColor: Colors.transparent,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    onTap: (ind) {
                                      if (ind == 0) {
                                        getAllDataBloc.add(
                                            OnPressedGetTransactiOnEvent(
                                                parentCode:
                                                    SharedPrefClass.getString(
                                                        AppStrings
                                                            .myReferralCode),
                                                txnType: ''));
                                      } else if (ind == 1) {
                                        getAllDataBloc.add(
                                            OnPressedGetTransactiOnEvent(
                                                parentCode:
                                                    SharedPrefClass.getString(
                                                        AppStrings
                                                            .myReferralCode),
                                                txnType: 'CREDIT'));
                                      } else {
                                        getAllDataBloc.add(
                                            OnPressedGetTransactiOnEvent(
                                                parentCode:
                                                    SharedPrefClass.getString(
                                                        AppStrings
                                                            .myReferralCode),
                                                txnType: 'DEBIT'));
                                      }
                                    },
                                    indicator: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        gradient: LinearGradient(colors: [
                                          AppColors.darkOrange,
                                          AppColors.lightOrange
                                        ])),
                                    unselectedLabelColor: AppColors.darkGrey,
                                    tabs: const [
                                      Tab(text: 'All'),
                                      Tab(text: 'Credit'),
                                      Tab(text: 'Withdraw'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: 56.h,
                                    // flex: MediaQuery.of(context).orientation ==
                                    //     Orientation.portrait
                                    //     ? 12
                                    //     : 10,
                                    child: BlocConsumer<GetAllDataBloc,
                                        GetAllDataState>(
                                      listener: ((context, state) {
                                        if (state is GetAllDataInitial) {
                                          setState(() {
                                            loading = state.loading;
                                          });
                                        } else if (state
                                            is GetTransactionLoaded) {
                                          setState(() {
                                            getTransactionModel =
                                                state.getTransactionModel;
                                          });
                                        }
                                      }),
                                      builder: ((context, state) {
                                        return loading == true
                                            ? AppWidgets.circularIndicator()
                                            : (getTransactionModel?.data ==
                                                        [] ||
                                                    getTransactionModel
                                                            ?.data?.length ==
                                                        0)
                                                ? Center(
                                                    child: Text(
                                                    'No Transaction Found',
                                                    style: AppTextStyles
                                                            .smallTextStyle()
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ))
                                                : TabBarView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    children: <Widget>[
                                                      AppWidgets.tabWidget(
                                                          getTransactionModel:
                                                              getTransactionModel),
                                                      AppWidgets.tabWidget(
                                                          getTransactionModel:
                                                              getTransactionModel),
                                                      AppWidgets.tabWidget(
                                                          getTransactionModel:
                                                              getTransactionModel),
                                                    ],
                                                  );
                                      }),
                                    ))
                              ]),
                        )),
                  ]))),
    );
  }
}
