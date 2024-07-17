import 'package:equatable/equatable.dart';

class JobStageUpdateEntities extends Equatable {
  final String stageId;
  final String bookingId;

  const JobStageUpdateEntities(
      {required this.stageId, required this.bookingId});

  @override
  List<Object> get props {
    return [stageId, bookingId];
  }

  @override
  bool get stringify => true;

  JobStageUpdateEntities copyWith({
    final String? stageId,
    final String? bookingId,
  }) {
    return JobStageUpdateEntities(
      stageId: stageId ?? this.stageId,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}
