import 'package:card_swiper/card_swiper.dart';
import 'package:desafio_raro_labs/components/custom_dialogs.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_control.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:desafio_raro_labs/tools/extensions/string_extension.dart';
import 'package:desafio_raro_labs/tools/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialControl{
  final parkingSizeTextField = TextEditingController(text: '0');
  final nameTextField = TextEditingController();

  final _controller = SwiperController();
  final _currentPage = 0.obs;

  SwiperController get swiperController => _controller;

  set currentPage(int idx) => _currentPage.value = idx;
  int get currentPage => _currentPage.value;

  previousPage() => _controller.previous();

  nextPage() => _controller.next();

  finalize(){
    OverlayControl.showWhile(() async{
      if(parkingSizeTextField.text.asInt == 0){
        return CustomDialog.show(
            text: 'Quantidade de vagas deve ser maior que 0.',
            title: 'Erro');

      }else if(nameTextField.text.trim().isEmpty){
        return CustomDialog.show(
            text: 'Nome não foi preenchido corretamente.',
            title: 'Erro');

      }

      await DBControl.registerUser(
          parkingSize: parkingSizeTextField.text.asInt,
          userName: nameTextField.text);

      Get.toNamed(Routes.main);
    });
  }
}