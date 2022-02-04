import 'package:flutter/material.dart';

class OverlayProgressWidgetSupport extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget? child;

  OverlayProgressWidgetSupport({
    this.inAsyncCall = false,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall)
      return child ?? Container();

    Widget layOutProgressIndicator;
    if (offset == null)
      layOutProgressIndicator = Center(
          child: progressIndicator);

    else
      layOutProgressIndicator = Positioned(
        child: progressIndicator,
        left: offset?.dx,
        top: offset?.dy);

    return Stack(
      children: [
        if(child != null)
          child!,
        Opacity(
          child: ModalBarrier(
              dismissible: dismissible,
              color: color),
          opacity: opacity),
        layOutProgressIndicator,
      ],
    );
  }
}