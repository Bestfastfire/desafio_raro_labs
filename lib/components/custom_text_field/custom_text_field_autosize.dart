import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';
import 'input_formatters.dart';

class CustomTextFieldAutoSize extends StatelessWidget {
  final TextEditingController controller;
  final TextInputFormatter? formatter;
  final String? prefix;
  final String? suffix;
  final Color color;

  final _focus = FocusNode();

  CustomTextFieldAutoSize({
    Key? key,
    required this.controller,
    this.color = Colors.white,
    this.formatter,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(prefix != null)
          InkWell(
              onTap: () => _focus.requestFocus(),
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 14),
                  child: CustomText(
                      color: color,
                      fontSize: 28,
                      text: prefix))),
        Flexible(
            child: AutoSizeTextField(
                focusNode: _focus,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    counter: SizedBox(
                        height: 0,
                        width: 0)),
                inputFormatters: [
                  formatter ?? IntInputFormatter()
                ],
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 48,
                    color: color),
                keyboardType: TextInputType.number,
                cursorColor: Colors.transparent,
                textAlign: TextAlign.start,
                controller: controller,
                showCursor: false,
                fullwidth: false,
                minFontSize: 24,
                cursorWidth: 0,
                maxLength: 14,
                minWidth: 50,
                minLines: 1,
                maxLines: 2)),
        if(suffix != null)
          InkWell(
              onTap: () => _focus.requestFocus(),
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 14),
                  child: CustomText(
                      color: color,
                      fontSize: 28,
                      text: suffix))),
      ],
    );
  }
}
