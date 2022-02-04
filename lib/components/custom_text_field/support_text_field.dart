import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'input_formatters.dart';
import '../custom_image.dart';

enum formType {
  any,
  multiline,
  money,
  age,
  int,
  date,
  float,
  password,
  email,
  phone,
  cellPhone
}

class TextValidate {
  static bool email(String value) {
    const pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)'
        r'*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}'
        r'\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';

    return RegExp(pattern).hasMatch(value);
  }

  static String? emailField(String value) =>
      email(value) ? null : 'E-mail inválido, tente novamente,';

  static bool password(String value) => kReleaseMode
      ? value.length > 7 : value.length > 7;

  static String? passwordField(String value) => password(value)
      ? null : 'Senha inválida, esta deve ter mais de 7 caracteres.';

  static bool phone(String value) => value.length == 12;

  static String? phoneField(String value) =>
      phone(value) ? null : 'Telefone inválido.';

  static bool cellPhone(String value) => value.length == 13;

  static String? cellPhoneField(String value) =>
      cellPhone(value) ? null : 'Telefone inválido.';
}

class TextFieldSupport {
  static const PASS_TYPE_LIST = [
    formType.password
  ];

  static TextInputType? getInputType({
    required formType type
  }) {
    if([
      formType.int,
      formType.money,
      formType.date,
      formType.age,
      formType.phone,
      formType.cellPhone,
      formType.float,
    ].contains(type)) {
      return TextInputType.number;

    }

    switch (type) {
      case formType.email:
        return TextInputType.emailAddress;

      case formType.multiline:
        return TextInputType.multiline;

      default:
        return null;
    }
  }

  static List<TextInputFormatter>? getInputFormatter({
    formType? type,
    String? format
  }) {
    if(format != null) {
      return [MaskTextInputFormatter(mask: format)];

    }

    if(type != null) {
      switch (type) {
        case formType.money:
          return [CurrencyInputFormatter()];

        case formType.date:
          return [DateInputFormatter()];

        case formType.age:
          return [MaskTextInputFormatter(mask: '###',
              filter: {"#": RegExp(r'[0-9]')})];

        case formType.int:
          return [MaskTextInputFormatter(mask: '##############################',
              filter: {"#": RegExp(r'[0-9]')})];

        case formType.phone:
          return [PhoneInputFormatter()];

        case formType.cellPhone:
          return [PhoneInputFormatter()];

        default:
          return null;
      }
    }

    return null;
  }

  static int? getMaxLength({
    required formType type
  }) {
    switch (type) {
      case formType.age:
        return 3;

      case formType.phone:
        return 18;

      case formType.cellPhone:
        return 18;

      default:
        return null;
    }
  }

  static int getMaxLine({
    required formType type
  }) {
    switch (type) {
      case formType.multiline:
        return 100;

      default:
        return 1;
    }
  }

  static Color getColor({
    bool background = false,
    bool white = false
  }) {
    if (background && white) {
      return Colors.white;

    }

    return Colors.black54;
  }

  static Widget? getPrefix({
    dynamic icon,
    color
  }) {
    if (icon != null) {
      return CustomImage(
          image: icon,
          color: color);

    }

    return null;
  }

  static Widget getSuffix({
      required formType type,
      required bool obscureText,
      required Function(bool value) onSuffix,
      required TextEditingController controller,
      required dynamic defaultV,
      Function(String v)? onChange
  }) {
    if (PASS_TYPE_LIST.contains(type)) {
      return IconButton(
          color: Colors.black54,
          icon: Icon(!obscureText
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () => onSuffix(!obscureText));

    } else if (defaultV != null) {
      return IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            controller.text = defaultV.toString();
            if (onChange != null) {
              onChange(defaultV.toString());

            }

            onSuffix(true);
          });
    }

    return IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          controller.text = '';
          if (onChange != null) {
            onChange('');

          }

          onSuffix(true);
        });
  }
}