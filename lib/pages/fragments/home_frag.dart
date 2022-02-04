import 'dart:developer';

import 'package:desafio_raro_labs/components/custom_text.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/control/home_control.dart';
import 'package:desafio_raro_labs/control/user_control.dart';
import 'package:desafio_raro_labs/model/parking_model.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFrag extends StatefulWidget {
  const HomeFrag({Key? key}) : super(key: key);

  @override
  _HomeFragState createState() => _HomeFragState();
}

class _HomeFragState extends State<HomeFrag> {
  final _control = HomeControl();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      log('state: ${UserControl.state}');

      return FutureBuilder<List<ParkingModel>>(
          future: DBControl.getParkingList(),
          builder: (c, snap){
            if(snap.data == null){
              return const Center(
                  child: CircularProgressIndicator());

            }

            return SingleChildScrollView(
                child: Wrap(
                    children: [
                      for(ParkingModel item in snap.data!)
                        Material(
                            color: item.isOccupied
                                ? CustomColors.primaryLight
                                : Colors.transparent,
                            child: InkWell(
                                onTap: () async{
                                  await _control.parkingState(item);
                                  UserControl.refreshList();

                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all()),
                                    alignment: Alignment.center,
                                    height: Get.width/4,
                                    width: Get.width/5,
                                    child: CustomText(
                                        color: Colors.white,
                                        text: item.number+1))))
                    ]));
          });
    });
  }
}
