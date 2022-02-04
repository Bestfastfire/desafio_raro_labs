import 'package:desafio_raro_labs/control/user_control.dart';
import 'package:desafio_raro_labs/model/app_bar_model.dart';
import 'package:desafio_raro_labs/pages/fragments/history_frag.dart';
import 'package:desafio_raro_labs/pages/fragments/home_frag.dart';
import 'package:desafio_raro_labs/tools/routes.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:flutter/material.dart';

class FragmentControl{
  static final navigatorKey = GlobalKey<NavigatorState>();
  static FragNavigate? fragNav;

  static FragNavigate _getNavigate(){
    return FragNavigate(
      firstKey: Routes.homeFrag,
      screens: <Posit>[
        Posit<AppBarModel>(
            key: Routes.homeFrag,
            fragment: const HomeFrag(),
            permissions: AppBarModel(
                centerTitle: true,
                title: 'Estacionamento',
                rightIcons: [
                  IconButton(
                      onPressed: () => UserControl.editParkingSize(),
                      icon: const Icon(Icons.edit))
                ])),
        Posit<AppBarModel>(
            key: Routes.historyFrag,
            fragment: const HistoryFrag(),
            permissions: AppBarModel(
                border: false,
                centerTitle: true,
                title: 'Histórico')),
      ]
    );
  }

  static restart() async {
    fragNav?.setInterface = null;
    await fragNav?.jumpBackToFirst();

    fragNav = _getNavigate();
  }
}