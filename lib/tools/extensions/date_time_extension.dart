import 'package:date_format/date_format.dart';

extension DT on DateTime{
  String get dbFormatted => formatDate(this, [
    yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);

  String get formatted => formatDate(this, [
    dd, '/', mm, '/', yyyy, ' às ', HH, ':', nn, ':', ss
  ], locale: const PortugueseDateLocale());

  String get formattedDateOnly => formatDate(this, [
    dd, '/', mm, '/', yyyy], locale: const PortugueseDateLocale());
}