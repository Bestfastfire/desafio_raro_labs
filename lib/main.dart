import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:desafio_raro_labs/components/custom_image.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_control.dart';
import 'package:desafio_raro_labs/control/fragment_control.dart';
import 'package:desafio_raro_labs/pages/tutorial_page.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/pages/main_page.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:desafio_raro_labs/tools/extensions/string_extension.dart';
import 'package:desafio_raro_labs/tools/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'Gerenciador de Vagas',
        routes: {
          Routes.main: (c) => const MainPage()
        },
        theme: ThemeData(
            primarySwatch: CustomColors.primarySwatch,
            primaryColor: Colors.white),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR')
        ],
        home: AnimatedSplashScreen.withScreenFunction(
          backgroundColor: CustomColors.primary,
          splash: CustomImage(
            image: 'ic_splash'.png,
            color: Colors.white,
            width: Get.width*.2),
          screenFunction: () async{
            final _hasUser = await DBControl.hasUser();
            FragmentControl.restart();
            OverlayControl();

            if(_hasUser){
              return const MainPage();

            }

            return const TutorialPage();
          }),
      ),
    );
  }
}
