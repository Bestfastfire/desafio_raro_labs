import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_rich_text/super_rich_text.dart';

import 'custom_image.dart';

enum TextType { light, regular, bold }

class CustomText extends StatelessWidget {
  final dynamic text;
  final double fontSize;
  final bool bold;
  final TextAlign align;
  final Color? color;
  final TextOverflow overflow;
  final TextDecoration underline;
  final TextType textType;
  final List<MarkerText>? markers;
  final FontWeight? fontWeight;
  final bool isRich;
  final bool wrap;

  final Color? iconColor;
  final double? iconSize;
  final dynamic icon;

  const CustomText({
    Key? key,
    required this.text,
    this.underline = TextDecoration.none,
    this.overflow = TextOverflow.clip,
    this.fontSize = 14,
    this.fontWeight,
    this.bold = false,
    this.isRich = false,
    this.align = TextAlign.left,
    this.textType = TextType.regular,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.markers,
    this.color,
    this.wrap = true,
  }) : super(key: key);

  factory CustomText.label(
          {required dynamic text,
          TextAlign align = TextAlign.start,
          double fontSize = 13,
          bool pad = true,
          Color? color}) =>
      CustomText(
          color: color ?? Colors.grey[700],
          text: (pad ? '  ' : '') + text.toString(),
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          align: align);

  factory CustomText.subTitle(
          {required dynamic text,
          Color color = Colors.grey,
          TextAlign align = TextAlign.start,
          double fontSize = 12}) =>
      CustomText(
          fontWeight: FontWeight.w500,
          text: text.toString(),
          fontSize: fontSize,
          color: color,
          align: align);

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.montserrat(
        decoration: underline,
        fontWeight: () {
          if (fontWeight != null) {
            return fontWeight;
          } else if (bold) {
            return FontWeight.bold;
          }

          switch (textType) {
            case TextType.light:
              return FontWeight.w300;

            case TextType.regular:
              return FontWeight.w400;

            case TextType.bold:
              return FontWeight.w700;
          }
        }(),
        fontSize: fontSize,
        color: color ?? Colors.grey[900]);

    final txt = isRich
        ? SuperRichText(
            othersMarkers: [
                ...(markers ?? []),
                MarkerText(
                    marker: '<p>',
                    style: style
                        .merge(const TextStyle(color: CustomColors.primary))),
                MarkerText(
                    marker: '<pl>',
                    style: style.merge(
                        const TextStyle(color: CustomColors.primaryLight))),
                MarkerText(
                    marker: '<h1>',
                    style: style.merge(
                        const TextStyle(fontSize: 22))),
                MarkerText(
                    marker: '<h2>',
                    style: style.merge(
                        const TextStyle(fontSize: 18)))
              ],
            overflow: overflow,
            textAlign: align,
            softWrap: wrap,
            style: style,
            text: text.toString())
        : Text(text.toString(),
            softWrap: wrap, style: style, textAlign: align, overflow: overflow);

    if (icon != null) {
      return Row(
        children: [
          CustomImage.icon(color: iconColor, width: iconSize, image: icon),
          const SizedBox(width: 10),
          Expanded(child: txt)
        ],
      );
    }

    return txt;
  }
}
