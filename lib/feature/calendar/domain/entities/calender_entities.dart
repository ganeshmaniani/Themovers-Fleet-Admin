import 'package:equatable/equatable.dart';

class CalenderEntities extends Equatable {
  final String fromDate;
  final String endDate;

  const CalenderEntities({required this.fromDate, required this.endDate});

  @override
  List<Object> get props => [fromDate, endDate];

  @override
  bool get stringify => true;

  CalenderEntities copyWith({final String? fromDate, final String? endDate}) {
    return CalenderEntities(
      fromDate: fromDate ?? this.fromDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
