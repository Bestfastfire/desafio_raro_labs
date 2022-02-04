import 'package:desafio_raro_labs/tools/extensions/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final dt = DateTime(2022, 1, 1, 15, 20);

  test('Formatadores', (){
    expect(dt.formatted, '01/01/2022 às 15:20:00');
    expect(dt.formattedDateOnly, '01/01/2022');
    expect(dt.dbFormatted, '2022-01-01 15:20:00');
  });
}