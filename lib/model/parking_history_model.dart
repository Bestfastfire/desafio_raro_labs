class ParkingHistoryModel{
  static const neverUsed = 'never_used';
  static const occupied = 'occupied';
  static const free = 'free';

  final DateTime? dateTime;
  final String type;
  final int number;

  bool get isOccupied => type == occupied;
  String get typeName => isOccupied
      ? 'Entrada' : 'Saída';

  factory ParkingHistoryModel(Map parking){
    final date = DateTime.tryParse(parking['datetime']);

    return ParkingHistoryModel._internal(date,
        parking['parking'], parking['type']);
  }

  factory ParkingHistoryModel.empty(int parking){
    return ParkingHistoryModel._internal(null, parking, neverUsed);
  }

  ParkingHistoryModel._internal(this.dateTime,
      this.number, this.type);
}