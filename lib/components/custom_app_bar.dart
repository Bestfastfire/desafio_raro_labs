import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_image.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? onBack;
  final bool centerTitle;
  final bool hideBack;
  final dynamic title;
  final Widget? iconLeft;
  final List<Widget>? iconsRight;
  final Color backgroundColor;
  final Color? backColor;
  final double height;
  final bool border;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomAppBar(
      {Key? key,
      this.title,
      this.hideBack = false,
      this.centerTitle = true,
      this.border = true,
      this.height = 60,
      this.onBack,
      this.backColor,
      this.iconLeft,
      this.iconsRight,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: (!hideBack
            ? CustomImage(
                onTap: onBack ?? Get.back,
                color: backColor ?? Colors.white,
                image: Icons.arrow_back_ios_outlined)
            : null),
        centerTitle: centerTitle,
        shape: border
            ? const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)))
            : null,
        backgroundColor: backgroundColor,
        toolbarHeight: height,
        actions: iconsRight,
        flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: border
                    ? const BorderRadius.vertical(bottom: Radius.circular(15))
                    : null,
                gradient: const LinearGradient(
                    begin: FractionalOffset(1.0, 1.0),
                    end: FractionalOffset(0.0, 0.0),
                    colors: [
                      CustomColors.primaryVeryBlack,
                      CustomColors.primaryBlack
                    ]))),
        elevation: 1,
        title: title is String
            ? CustomText(
                text: title, color: Colors.white, fontSize: 16, bold: true)
            : title);
  }
}
