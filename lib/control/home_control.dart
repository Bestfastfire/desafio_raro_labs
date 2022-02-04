import 'package:desafio_raro_labs/components/overlay_progress/overlay_control.dart';
import 'package:desafio_raro_labs/components/custom_datetime_picker.dart';
import 'package:desafio_raro_labs/components/custom_dialogs.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/model/parking_history_model.dart';
import 'package:desafio_raro_labs/model/parking_model.dart';
import 'package:flutter/material.dart';

class HomeControl{
  Future parkingState(ParkingModel model) async{
    DateTime _date = DateTime.now();
    final _title = !model.isOccupied
        ? 'Entrada' : 'Saída';

    final res = await CustomDialog.toConfirm(
      title: '$_title (${model.number+1}):',
      content: Column(
        children: [
          CustomDateTimePicker(
              onChange: (date) => _date = date!,
              label: 'Horário de $_title',
              init: _date)
        ]));

    if(res ?? false){
      OverlayControl.showWhile(() async{
        await DBControl.putHistory(model.number, !model.isOccupied
            ? ParkingHistoryModel.occupied
            : ParkingHistoryModel.free, _date);
      });
    }
  }
}