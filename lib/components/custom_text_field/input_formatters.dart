import '../../tools/extensions/string_extension.dart';
import 'package:flutter/services.dart';
import './text_formatters.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final bool showCurrency;

  CurrencyInputFormatter([this.showCurrency = true]);

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) {
      return newValue;

    }

    String newText = TextFormatter
        .textFieldToReal(newValue.text);

    if(!showCurrency) {
      newText = newText.replaceAll('R\$', '').trim();

    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection
            .collapsed(offset: newText.length));
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String old = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String v = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (oldValue.text.length > newValue.text.length && old.length == v.length){
      if (v.isNotEmpty) {
        v = v.substring(0, v.length - 1);

      }
    }

    if(v.length <= 10 && v.length > 1) {
      v = v.getMasked('## ####-####');

    } else if(v.length > 10) {
      v = v.getMasked('## #####-####');

    }

    return newValue.copyWith(
        text: v,
        selection: TextSelection
            .collapsed(offset: v.length));
  }
}

class DateInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String old = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String v = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if(oldValue.text.length > newValue.text.length && old.length == v.length){
      if(v.isNotEmpty) {
        v = v.substring(0, v.length-1);

      }
    }

    v = v.getMasked('##/##/####');

    return newValue.copyWith(
        text: v,
        selection: TextSelection
            .collapsed(offset: v.length));
  }
}

class IntInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.asInt.toString();

    return newValue.copyWith(
        text: newText,
        selection: TextSelection
            .collapsed(offset: newText.length));
  }
}