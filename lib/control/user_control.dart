import 'package:desafio_raro_labs/components/custom_dialogs.dart';
import 'package:desafio_raro_labs/components/custom_text_field/custom_text_field.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_control.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/tools/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserControl{
  static final Rx<bool> _state = true.obs;
  static bool get state => _state.value;

  static refreshList(){
    _state.refresh();

  }

  static editParkingSize() async{
    final user = await DBControl.getCurrentUser();

    final _size = TextEditingController(
      text: '${user?.parkingSize ?? '0'}');

    if(user != null){
      final res = await CustomDialog.toConfirm(
          title: 'Quantidade de Vagas:',
          txtNegative: 'Cancelar',
          txtPositive: 'Salvar',
          content: CustomTextField(
              type: formType.int,
              controller: _size));

      if(res ?? false){
        if(_size.text.asInt == 0){
          return CustomDialog.show(
              text: 'Quantidade de vagas deve ser maior que 0.',
              title: 'Erro');

        }

        OverlayControl.showWhile(() async{
          await DBControl.updateParkingSize(
              _size.text.asInt, user.id);
          refreshList();

        });
      }
    }
  }
}