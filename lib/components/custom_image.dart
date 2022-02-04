import 'package:flutter/material.dart';
import 'package:get/get.dart';

export '../tools/extensions/string_extension.dart';

class CustomImage extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final dynamic image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Function? onTap;
  final bool circular;

  factory CustomImage(
          {required dynamic image,
          Function? onTap,
          Color? color,
          double? width = 25,
          double? height,
          bool circular = false,
          BoxFit fit = BoxFit.contain}) =>
      CustomImage._internal(
          circular: circular,
          onTap: onTap,
          height: height,
          width: width,
          color: color,
          fit: fit,
          image: image);

  factory CustomImage.icon(
          {required dynamic image,
          Function? onTap,
          Color? color,
          double? width = 25,
          double? height,
          BoxFit fit = BoxFit.contain}) =>
      CustomImage._internal(
          color: color ?? Colors.grey[700],
          onTap: onTap,
          height: height,
          width: width,
          fit: fit,
          image: image);

  factory CustomImage.button(
          {required dynamic image,
          required Function() onTap,
          double? width = 25,
          double? height,
          BoxFit fit = BoxFit.contain,
          bool circular = false}) =>
      CustomImage._internal(
          circular: circular,
          height: height,
          onTap: onTap,
          width: width,
          image: image,
          fit: fit);

  const CustomImage._internal(
      {required this.image,
      this.color,
      this.circular = false,
      this.width = 25,
      this.height,
      this.fit = BoxFit.contain,
      this.onTap,
      this.padding});

  Widget _circular(Widget child) => circular
      ? ClipRRect(
          borderRadius: BorderRadius.circular(Get.size.longestSide),
          child: child)
      : child;

  Widget getIcon() {
    Widget _icon() {
      if (image is IconData) {
        return Icon(image, color: color, size: width);
      } else if (image is Widget) {
        return image;
      }

      return Image.asset(image,
          fit: fit, color: color, width: width, height: height);
    }

    return Container(margin: padding, child: _icon());
  }

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? IconButton(onPressed: () => onTap!(), icon: _circular(getIcon()))
        : _circular(getIcon());
  }
}
