import 'package:equatable/equatable.dart';

class JobDeleteEntities extends Equatable {
  final int userId;
  final String bookingId;
  final String description;

  const JobDeleteEntities({
    required this.userId,
    required this.bookingId,
    required this.description,
  });

  @override
  List<Object> get props {
    return [userId, bookingId, description];
  }

  @override
  bool get stringify => true;

  JobDeleteEntities copyWith({
    final int? userId,
    final String? bookingId,
    final String? description,
  }) {
    return JobDeleteEntities(
      userId: userId ?? this.userId,
      bookingId: bookingId ?? this.bookingId,
      description: description ?? this.description,
    );
  }
}
