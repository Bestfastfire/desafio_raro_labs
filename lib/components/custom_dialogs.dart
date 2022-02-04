import 'dart:developer';

import 'package:desafio_raro_labs/tools/widget_tools.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class CustomDialog {
  static Future show(
      {BuildContext? context,
      String? title,
      String? text,
      String? txtPositive,
      String? txtNegative,
      String? txtNeuter,
      Function? onPositive,
      Function? onNegative,
      Function? onNeuter,
      Widget? content,
      bool dismissible = true,
      bool popAfterPositive = true,
      bool popAfterNeuter = true,
      bool popAfterNegative = true,
      bool clean = false,
      bool scrollable = true,
      EdgeInsets? margin
  }) async {
    return await Get.dialog(
        GestureDetector(
            onTap: () => WidgetTools.removeFocus(),
            child: Container(
              margin: margin ?? const EdgeInsets.only(bottom: 60),
              child: AlertDialog(
                scrollable: scrollable,
                contentPadding: !clean
                    ? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0)
                    : const EdgeInsets.all(0),
                insetPadding: !clean
                    ? const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0)
                    : const EdgeInsets.all(0),
                backgroundColor: clean ? Colors.transparent : Colors.white,
                title: title != null ? Text(title) : null,
                content: content ??
                    CustomText(text: text.toString(), align: TextAlign.justify),
                actions: clean
                    ? null
                    : <Widget>[
                        if (txtNegative != null)
                          CustomButton(
                            textColor: CustomColors.primaryBlack,
                            text: txtNegative,
                            flat: true,
                            onTap: () async {
                              try {
                                if (onNegative != null) {
                                  await onNegative();
                                }

                                if (popAfterNegative) {
                                  Get.back();
                                }
                              } catch (msg) {
                                log('onNegative catch -> $msg');
                              }
                            },
                          ),
                        if (txtNegative != null) const SizedBox(width: 10),
                        if (txtNeuter != null)
                          CustomButton(
                            textColor: CustomColors.primaryBlack,
                            text: txtNeuter,
                            flat: true,
                            onTap: () async {
                              try {
                                if (onNeuter != null) {
                                  await onNeuter();
                                }

                                if (popAfterNeuter) {
                                  Get.back();
                                }
                              } catch (msg) {
                                log('onNeuter catch -> $msg');
                              }
                            },
                          ),
                        if (txtNeuter != null) const SizedBox(width: 10),
                        CustomButton(
                          textColor: CustomColors.primaryBlack,
                          text: txtPositive ?? "Ok",
                          flat: true,
                          onTap: () async {
                            try {
                              if (onPositive != null) {
                                await onPositive();
                              }

                              if (popAfterPositive) {
                                Get.back();
                              }
                            } catch (msg) {
                              log('onPositive catch -> $msg');
                            }
                          },
                        ),
                      ],
              ),
            )),
        barrierDismissible: dismissible);
  }

  static Future<bool?> toConfirm(
      {String? text,
      Widget? content,
      String? txtPositive,
      String? txtNegative,
      String? txtNeuter,
      bool dismissible = true,
      String? title}) async {
    bool? toReturn = false;

    await show(
        txtPositive: txtPositive ?? 'Confirmar',
        txtNegative: txtNegative ?? 'Cancelar',
        onPositive: () => toReturn = true,
        onNeuter: () => toReturn = null,
        dismissible: dismissible,
        txtNeuter: txtNeuter,
        content: content,
        title: title,
        text: text);

    return toReturn;
  }
}
