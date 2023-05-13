import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:traget_plus/bloc/auth/authentication_bloc.dart';
import 'package:traget_plus/bloc/getData/get_all_data_bloc.dart';
import 'package:traget_plus/routeHelper/route_helper.dart';
import 'package:traget_plus/utils/app_colors.dart';
import 'package:traget_plus/utils/sharedPref.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  SharedPrefClass.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc()),
            BlocProvider<GetAllDataBloc>(create: (_) => GetAllDataBloc()),
          ],
          child: GetMaterialApp(
            title: 'Target +',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: AppColors.boxColor1,
                hintColor: AppColors.boxColor1,
                secondaryHeaderColor: AppColors.boxColor1),
            initialRoute: RouteHelper.splash,
            getPages: RouteHelper.getPages,
          ));
    }));
  }
}
