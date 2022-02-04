import './../../tools/extensions/string_extension.dart';
import 'package:intl/intl.dart';

class TextFormatter{
  static String toReal(v, {
    bool showSymbol = true,
    String? caseCatch
  }){
    String value = 'R\$ 0,00';

    try{
      String nValue = v.toString().replaceAll('R\$', '').trim();

      if(nValue.contains('.')){
        for(int i = nValue.split('.')[1].length; i < 2; i++) {
          nValue += '0';

        }

      }else {
        nValue += '00';

      }

      nValue = nValue.replaceAll('.', '');

      final formatter = NumberFormat
          .simpleCurrency(locale: "pt_Br");

      value = formatter.format(double.parse(nValue)/100);

    }catch(msg){
      if(caseCatch != null) {
        value = 'R\$ $caseCatch';

      }
    }

    return !showSymbol
        ? value.replaceAll('R\$', '').trim()
        : value;
  }

  static String textFieldToReal(v){
    try{
      v = v.toString()
          .replaceAll('R\$', '')
          .replaceAll(',', '')
          .replaceAll('.', '')
          .trim();

      final value = double.parse(v);

      final formatter = NumberFormat
          .simpleCurrency(locale: "pt_Br");

      return formatter.format(value/100);

    }catch(msg){
      return 'R\$ 0,00';

    }
  }

  static cpfObscured(String cpf) => obscure(cpf, showOnly: [
    3, 4, 5, 6, 7, 8, 9, 10, 11
  ]);

  static String obscure(String text, {
    List<int> showOnly = const [12, 13, 14, 15, 16],
    String mask = '#### #### #### #####',
    String obscureCharacter = '*'
  }){
    try{
      text = text.replaceAll(' ', '');
      String result = '';

      for(int i = 0; i < text.length; i++) {
        result += !showOnly.contains(i)
                ? obscureCharacter
                : text[i];

      }

      return result.getMasked(mask);

    }catch(msg){
      return 'NULL';

    }
  }
}