import 'package:desafio_raro_labs/model/app_bar_model.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_image.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget  implements PreferredSizeWidget {
  final Function? onBack;
  final bool centerTitle;
  final bool hideBack;
  final dynamic title;
  final Widget? iconLeft;
  final List<Widget>? iconsRight;
  final AppBarModel? model;
  final Color backgroundColor;
  final Color? backColor;
  final double? height;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

   const CustomAppBar({Key? key,
    this.title,
    this.hideBack = false,
    this.centerTitle = true,
    this.height,
    this.model,
    this.onBack,
    this.backColor,
    this.iconLeft,
    this.iconsRight,
    this.backgroundColor = CustomColors.primary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: model?.leftIcon ?? (!hideBack
            ? CustomImage(
              onTap: onBack ?? Get.back,
              color: backColor ?? Colors.white,
              image: Icons.arrow_back_ios_outlined)
            : null),
        centerTitle: model?.centerTitle ?? centerTitle,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular((model?.border ?? true)
                    ? 15 : 0))),
        backgroundColor: backgroundColor,
        toolbarHeight: height,
        actions: model?.rightIcons
            ?? iconsRight,
        elevation: 1,
        title: title is String || model?.title is String
            ? CustomText(
                text: title ?? model?.title,
                color: Colors.white,
                fontSize: 16)
            : (title ?? model?.title));
  }
}