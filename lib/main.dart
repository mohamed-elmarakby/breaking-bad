import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/my_colors.dart';

import 'app_router.dart';
import 'service_locator.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  setupGetIt();
  serviceLocator.allReady();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarIconBrightness: Brightness.light,
      // statusBarBrightness: Brightness.dark,
      // systemNavigationBarColor: MyColors.myYellow,
      ));
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter? appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaking Bad',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter!.generateRoute,
      theme: ThemeData(
        primaryColor: MyColors.myYellow,
        brightness: Brightness.dark,
      ),
    );
  }
}
