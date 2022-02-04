import 'package:desafio_raro_labs/tools/extensions/date_time_extension.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_image.dart';
import 'custom_text.dart';

class CustomAppBarFilter extends StatefulWidget implements PreferredSizeWidget{
  final Rx<DateTime> dateTimeRange;

  const CustomAppBarFilter({
    Key? key,
    required this.dateTimeRange
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  _CustomAppBarFilterState createState() => _CustomAppBarFilterState();
}

class _CustomAppBarFilterState extends State<CustomAppBarFilter> {
  Rx<DateTime> get dateTimeRange => widget.dateTimeRange;

  Widget _button({
    bool isRight = false
  }) => InkWell(
      onTap: (){
        if(isRight){
          dateTimeRange.value = dateTimeRange.value
              .add(const Duration(days: 1));

        }else{
          dateTimeRange.value= dateTimeRange.value
              .add(const Duration(days: -1));

        }
      },
      child: Container(
          height: 35,
          width: 35,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey),
          child: CustomImage(
              image: isRight
                  ? Icons.arrow_right_sharp
                  : Icons.arrow_left_sharp,
              color: Colors.white)));

  @override
  Widget build(BuildContext context) {
    return AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15))),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: FractionalOffset(1.0, 1.0),
                    end: FractionalOffset(0.0, 0.0),
                    colors: [
                      CustomColors.primaryBlack,
                      CustomColors.primary
                    ]))),
        title: Obx(() => CustomText(
            text: dateTimeRange.value.formattedDateOnly,
            align: TextAlign.center,
            color: Colors.white)),
        centerTitle: true,
        leading: _button(),
        actions: [
          _button(
              isRight: true)
        ]);
  }
}

