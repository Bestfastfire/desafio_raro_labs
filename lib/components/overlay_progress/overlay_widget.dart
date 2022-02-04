import 'package:desafio_raro_labs/tools/widget_tools.dart';

import './_overlay_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'overlay_control.dart';

class OverlayProgress extends StatefulWidget {
  final OverlayControl? control;
  final Widget child;

  bool _initialValue = false;

  OverlayProgress({
    Key? key,
    required this.child,
    bool setValue = false,
    this.control
  }) : super(key: key) {
    _initialValue = setValue;

  }

  @override
  _OverlayProgressState createState() => _OverlayProgressState();
}

class _OverlayProgressState extends State<OverlayProgress> {
  _init(){
    if(widget.control == null) {
      if (widget._initialValue != OverlayControl.currentState) {
        OverlayControl.setState = widget._initialValue;
      }

    }else {
      if (widget._initialValue != OverlayControl.currentState) {
        widget.control!.setStateInside = widget._initialValue;
      }

    }
  }

  @override
  void initState() {
    super.initState();
    WidgetTools.doSafetyWhileBuild(() async => _init());

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx((){
          final currentMessage = widget.control?.message
              ?? OverlayControl.currentMessage;

          final currentState = widget.control?.state
              ?? OverlayControl.currentState;

          if(currentState && currentMessage.trim().isNotEmpty) {
            return Center(
                child: Card(
                    margin: const EdgeInsets.only(
                        top: 100),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10),
                        child: Text(
                            currentMessage,
                            style: const TextStyle(
                                color: Colors.black)))));
          }

          return widget.child;
        }),
        Positioned.fill(
            bottom: 0,
            child: Obx(() => OverlayProgressWidgetSupport(
                inAsyncCall: widget.control?.state
                    ?? OverlayControl.currentState,
                // child: widget.child,
                opacity: 0.4))),
      ],
    );
  }
}
