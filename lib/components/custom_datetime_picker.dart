import 'package:desafio_raro_labs/components/custom_text.dart';
import './../tools/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_dialogs.dart';

class CustomDateTimePicker extends StatefulWidget {
  final Function(DateTime? v) onChange;
  final bool dateOnly;
  final bool showReset;
  final DateTime init;
  final String? label;

  const CustomDateTimePicker({Key? key,
    required this.onChange,
    required this.init,
    this.showReset = false,
    this.dateOnly = false,
    this.label}) : super(key: key);

  @override
  _CustomDateTimePickerState createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  final _date = Rx<DateTime?>(null);

  CustomDateTimePicker get w => widget;

  @override
  void initState() {
    super.initState();
    _date.value = w.init;
  }

  sink(DateTime? date, [bool force = false]){
    if(date != null || force){
      _date.value = date;
      w.onChange(_date.value);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
        children: [
          Expanded(
              child: GestureDetector(
                  onTap: () async {
                    final v = widget.dateOnly
                        ? await CustomDialog.getDatePicker(
                            context: context, dateTime: _date.value)
                        : await CustomDialog.getDateTimePicker(
                            context: context, dateTime: _date.value);

                    if (v != null) {
                      sink(v);

                    }
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(widget.label != null)
                          CustomText.label(
                              text: widget.label),

                        Row(
                          children: [
                            Expanded(
                                child: CustomText(
                                    text: (widget.dateOnly
                                        ? _date.value?.formattedDateOnly
                                        : _date.value?.formatted) ?? '[Clique Aqui]',
                                    color: Colors.blueAccent,
                                    fontSize: 14)),
                            if(widget.showReset)
                              SizedBox(
                                  height: 20,
                                  child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(Icons.close,
                                          color: Colors.black54,
                                          size: 20),
                                      onPressed: () => sink(null, true)))
                          ],
                        ),
                      ]
                  )))
        ]
    ));
  }
}
