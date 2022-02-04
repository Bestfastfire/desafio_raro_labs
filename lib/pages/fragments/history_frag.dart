import 'package:desafio_raro_labs/components/custom_app_bar_filter.dart';
import 'package:desafio_raro_labs/tools/colors.dart';
import 'package:desafio_raro_labs/tools/extensions/date_time_extension.dart';
import 'package:desafio_raro_labs/model/parking_history_model.dart';
import 'package:desafio_raro_labs/components/custom_text.dart';
import 'package:desafio_raro_labs/control/db_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryFrag extends StatefulWidget {
  const HistoryFrag({Key? key}) : super(key: key);

  @override
  _HistoryFragState createState() => _HistoryFragState();
}

class _HistoryFragState extends State<HistoryFrag> {
  final Rx<DateTime> dateTimeRange = DateTime.now().obs;
  DateTime get dt => dateTimeRange.value;

  DateTime get rangeStart => DateTime(dt.year, dt.month, dt.day);
  DateTime get rangeEnd => rangeStart.add(
      const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarFilter(
          dateTimeRange: dateTimeRange),
      backgroundColor: Colors.transparent,
      body: Obx((){
        final start = rangeStart;
        final end = rangeEnd;

        return FutureBuilder<List<ParkingHistoryModel>>(
            future: DBControl.getParkingHistory(start.millisecondsSinceEpoch,
                end.millisecondsSinceEpoch),
            builder: (c, snap){
              if(snap.data == null){
                return const Center(
                    child: CircularProgressIndicator());

              }

              final list = snap.data!;

              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (c, idx){
                    final item = list[idx];

                    return Card(
                        color: CustomColors.primaryLight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5),
                        child: ListTile(
                            onTap: (){},
                            title: CustomText(
                                text: '${item.typeName} na Vaga: ${item.number+1}',
                                color: Colors.white),
                            subtitle: CustomText(
                                text: 'Data: ${item.dateTime?.formatted}',
                                color: Colors.white)));
                  });
            });
      }),
    );
  }
}
