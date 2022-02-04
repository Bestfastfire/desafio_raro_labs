import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextIcon extends StatelessWidget {
  final String title;
  final dynamic icon;

  const CustomTextIcon({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: CustomText(
            iconColor: Colors.grey[100],
            color: Colors.white,
            iconSize: 25,
            isRich: true,
            text: title,
            icon: icon));
  }
}
