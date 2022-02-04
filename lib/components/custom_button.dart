import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'custom_image.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final dynamic text;
  final Function()? onTap;
  final Color? borderColor;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final TextOverflow overflow;
  final double? elevation;
  final double fontSize;
  final double radius;
  final dynamic icon;
  final bool bold;
  final bool flat;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTap,
      this.bold = false,
      this.flat = false,
      this.icon,
      this.radius = 20,
      this.overflow = TextOverflow.clip,
      this.borderColor,
      this.color,
      this.textColor,
      this.elevation,
      this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      this.fontSize = 12})
      : super(key: key);

  factory CustomButton.main(
          {required text, Function()? onTap, double horizontalPadding = 75}) =>
      CustomButton(
          color: CustomColors.primary,
          text: text,
          radius: 10,
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
          onTap: onTap);

  @override
  Widget build(BuildContext context) {
    final txt = text is String
        ? CustomText(
            text: text,
            overflow: overflow,
            fontSize: fontSize,
            color: textColor ?? (onTap != null ? Colors.white : Colors.black54),
            bold: bold)
        : text;

    final style = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        elevation: elevation,
        padding: padding,
        primary: color);

    if (flat) {
      return icon != null
          ? TextButton.icon(
              style: style,
              onPressed: onTap,
              icon: CustomImage(image: icon),
              label: txt)
          : TextButton(onPressed: onTap, style: style, child: txt);
    }

    return icon != null
        ? ElevatedButton.icon(
            style: style,
            onPressed: onTap,
            icon: CustomImage(image: icon),
            label: txt)
        : ElevatedButton(onPressed: onTap, style: style, child: txt);
  }
}
