import 'package:card_swiper/card_swiper.dart';
import 'package:desafio_raro_labs/components/custom_button.dart';
import 'package:desafio_raro_labs/components/custom_image.dart';
import 'package:desafio_raro_labs/components/custom_text.dart';
import 'package:desafio_raro_labs/components/custom_text_field/custom_text_field.dart';
import 'package:desafio_raro_labs/components/custom_text_field/custom_text_field_autosize.dart';
import 'package:desafio_raro_labs/components/overlay_progress/overlay_widget.dart';
import 'package:desafio_raro_labs/control/tutorial_control.dart';
import 'package:desafio_raro_labs/tools/widget_tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final _control = TutorialControl();
  final colors = const [
    Color.fromRGBO(16, 33, 75, 1),
    Color.fromRGBO(99, 41, 132, 1),
    // Color.fromRGBO(84, 144, 61, 1),
    // Color.fromRGBO(215, 106, 0, 1)
  ];

  final texts = [
    '<h1>Bem-vindo(a) ao GERENCIADOR DE VAGAS!<h1>\n\nPara começar a utilizar '
        'defina a quantidade de vagas do seu estacionamento:',
    '<h2>Pra finalizar digite o seu nome:<h2>'
  ];

  @override
  Widget build(BuildContext context) {
    return OverlayProgress(
      child: GestureDetector(
        onTap: WidgetTools.removeFocus,
        child: Scaffold(
          body: Stack(
            children: [
              Swiper(
                  onIndexChanged: (i) => _control.currentPage = i,
                  controller: _control.swiperController,
                  pagination: SwiperPagination(
                      margin: const EdgeInsets.all(20),
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.grey[850],
                          color: Colors.grey[400])),
                  itemCount: 2,
                  loop: false,
                  itemBuilder: (c, index) => Container(
                      color: colors[index],
                      height: Get.height,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 35),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        CustomText(
                                            align: TextAlign.center,
                                            color: Colors.white,
                                            text: texts[index],
                                            isRich: true),
                                        const SizedBox(
                                            height: 15),

                                        if(index == 0)
                                          CustomTextFieldAutoSize(
                                              controller: _control.parkingSizeTextField,
                                              suffix: 'Vagas')

                                        else if(index == 1)
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                            child: CustomTextField(
                                                controller: _control.nameTextField,
                                                color: Colors.white,
                                                border: true,))
                                    ],
                                  ),
                                ))),

                          if(index == colors.length-1)
                            Positioned(
                                bottom: 55,
                                right: 0,
                                left: 0,
                                child: Center(
                                    child: CustomButton(
                                        onTap: _control.finalize,
                                        textColor: Colors.white,
                                        text: 'Continuar',
                                        fontSize: 16,
                                        flat: true)))
                        ],
                      ))),
              Obx(() => Positioned(
                  child: _control.currentPage < 3 ? Align(
                      alignment: Alignment.centerRight,
                      child: CustomImage(
                          onTap: () => _control.nextPage(),
                          image: Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                          width: 45))
                      : Container())),
              Obx(() => Positioned(
                  child: _control.currentPage > 0 ? Align(
                      alignment: Alignment.centerLeft,
                      child: CustomImage(
                          onTap: () => _control.previousPage(),
                          image: Icons.keyboard_arrow_left_sharp,
                          color: Colors.white,
                          width: 45))
                      : Container()))
            ],
          ),
        ),
      ),
    );
  }
}
