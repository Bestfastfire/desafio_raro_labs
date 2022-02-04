import 'package:flutter/cupertino.dart';

class AppBarModel{
  final dynamic title;
  final bool centerTitle;
  final List<Widget>? rightIcons;
  final Widget? leftIcon;
  final bool border;

  AppBarModel({
    required this.title,
    this.centerTitle = false,
    this.border = true,
    this.rightIcons,
    this.leftIcon});
}