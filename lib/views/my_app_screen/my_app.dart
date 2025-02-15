import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import '../../config/all_providers.dart';
import '../../services/internet_conectivity_checker.dart';
import '../../utils/routing.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late ConnectivityService _connectivityService;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _connectivityService = ConnectivityService();
    _connectivityService.connectivityStream.listen((hasInternet) {
      setState(() {
        _hasInternet = hasInternet;
      });
    });
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: AppAllProviders.appAllProviders,
        child: Platform.isIOS ?  CupertinoApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            routerDelegate: AppRoute.router.routerDelegate,
            routeInformationProvider: AppRoute.router.routeInformationProvider,
            routeInformationParser: AppRoute.router.routeInformationParser,
          ):
          GetMaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            routerDelegate: AppRoute.router.routerDelegate,
            routeInformationProvider: AppRoute.router.routeInformationProvider,
            routeInformationParser: AppRoute.router.routeInformationParser,
          ),
      ),
    );
  }
}
