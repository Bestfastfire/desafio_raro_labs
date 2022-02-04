import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_control.dart';
import 'package:desafio_raro_labs/pages/tutorial_page.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/pages/main_page.dart';
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
        home: AnimatedSplashScreen.withScreenFunction(
          splash: '',
          screenFunction: () async{
            final _hasUser = await DBControl.hasUser();
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
