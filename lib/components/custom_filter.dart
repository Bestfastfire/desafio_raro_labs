import 'package:desafio_raro_labs/components/custom_image.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFilter extends StatelessWidget {
  final Function(String txt) onFilter;
  final bool show;

  final _controller = TextEditingController();
  final RxBool favorite;

  CustomFilter(
      {Key? key,
      required this.favorite,
      required this.onFilter,
      required this.show})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = GoogleFonts.montserrat(color: Colors.white, fontSize: 14);

    return AnimatedContainer(
        height: show ? 60 : 0,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        duration: const Duration(milliseconds: 200),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            gradient: LinearGradient(
                begin: FractionalOffset(1.0, 1.0),
                end: FractionalOffset(0.0, 0.0),
                colors: [
                  CustomColors.primaryVeryBlack,
                  CustomColors.primaryBlack,
                ])),
        child: show
            ? Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: _controller,
                          cursorColor: Colors.white,
                          onChanged: onFilter,
                          style: _style,
                          decoration: InputDecoration(
                              hintText: 'Digite aqui...',
                              border: InputBorder.none,
                              hintStyle: _style))),
                  Obx(() => CustomImage(
                      onTap: () => favorite.value = !favorite.value,
                      color: favorite.value ? Colors.amber : Colors.grey,
                      image: Icons.star))
                ],
              )
            : null);
  }
}
