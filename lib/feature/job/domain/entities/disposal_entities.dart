import 'package:equatable/equatable.dart';

class DisposalEntities extends Equatable {
  final int userId;
  final String customerId;
  final String bookingId;
  final String bookingDate;
  final String serviceType;
  final String vehicleType;
  final double amount;
  final double totalAmount;

  const DisposalEntities({
    required this.userId,
    required this.bookingDate,
    required this.customerId,
    required this.serviceType,
    required this.bookingId,
    required this.vehicleType,
    required this.amount,
    required this.totalAmount,
  });

  @override
  List<Object> get props {
    return [
      userId,
      customerId,
      bookingDate,
      serviceType,
      bookingId,
      vehicleType,
      amount,
      totalAmount,
    ];
  }

  @override
  bool get stringify => true;

  DisposalEntities copyWith({
    final int? userId,
    final String? bookingDate,
    final String? customerId,
    final String? serviceType,
    final String? bookingId,
    final String? vehicleType,
    final double? amount,
    final double? totalAmount,
  }) {
    return DisposalEntities(
      userId: userId ?? this.userId,
      bookingDate: bookingDate ?? this.bookingDate,
      customerId: customerId ?? this.customerId,
      serviceType: serviceType ?? this.serviceType,
      bookingId: bookingId ?? this.bookingId,
      vehicleType: vehicleType ?? this.vehicleType,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
