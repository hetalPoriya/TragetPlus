import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/utils/utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GetAllDataBloc getAllDataBloc = GetAllDataBloc();
  bool loading = true;

  @override
  void initState() {
    getAllDataBloc = BlocProvider.of<GetAllDataBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          AppWidgets.smallHalfRect(
              child: Column(
            children: [
              AppWidgets.appBarWidget(),
              AppWidgets.userInfo(),
            ],
          )),
          SizedBox(
            height: 6.h,
          ),
          Center(
            child: Text(
              'Notification Not found',
              style:
                  AppTextStyles.smallTextStyle().copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    ));
  }
}
