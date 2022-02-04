import 'dart:io';

import 'package:desafio_raro_labs/components/custom_app_bar.dart';
import 'package:desafio_raro_labs/components/custom_image.dart';
import 'package:desafio_raro_labs/components/custom_text.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_widget.dart';
import 'package:desafio_raro_labs/control/fragment_control.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:desafio_raro_labs/tools/routes.dart';
import 'package:desafio_raro_labs/tools/widget_tools.dart';
import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-control.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FragNavigate get fragNav => FragmentControl.fragNav!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(fragNav.stack.length > 1){
          fragNav.jumpBack();
          return false;

        }

        return true;
      },
      child: GestureDetector(
        onTap: WidgetTools.removeFocus,
        child: OverlayProgress(
          child: StreamBuilder<FullPosit>(
              stream: fragNav.outStreamFragment,
              builder: (context, data){
                if(data.data == null) {
                  return const Center(
                      child: CircularProgressIndicator());

                }

                final _frag = data.data;
                final _index = Routes.currentKey[_frag?.key ?? 0] ?? 0;

                return Scaffold(
                    backgroundColor: CustomColors.primaryBlack,
                    key: fragNav.drawerKey,
                    appBar: CustomAppBar(
                        hideBack: fragNav.stack.length < 2,
                        onBack: fragNav.jumpBack,
                        model: _frag!.permissions),
                    body: _frag.fragment,
                    bottomNavigationBar: Material(
                      color: CustomColors.primary,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: Platform.isIOS
                                ? 18 : 0),
                        height: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _btnNavigation(
                                onTap: () => fragNav.putPosit(
                                    key: Routes.homeFrag),
                                selected: _index == 0,
                                icon: Icons.home,
                                text: 'Home'),
                            const SizedBox(
                                width: 30),
                            _btnNavigation(
                                onTap: () => fragNav.putPosit(
                                    key: Routes.historyFrag),
                                selected: _index == 1,
                                icon: Icons.list,
                                text: 'Histórico',
                                margin: 3),
                          ],
                        ),
                      ),
                    ),
                  );
              }),
        ),
      ),
    );
  }

  _btnNavigation({
    required Function() onTap,
    required dynamic icon,
    required bool selected,
    required String text,
    double margin = 0
  }) => Expanded(
    child: InkWell(
        borderRadius: BorderRadius.circular(35),
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                    image: icon,
                    color: selected
                        ? Colors.white
                        : Colors.grey),
                SizedBox(
                    height: margin),
                CustomText(
                    text: text,
                    fontSize: 12,
                    color: selected
                        ? Colors.white
                        : Colors.grey),
              ],
            ))),
  );
}
