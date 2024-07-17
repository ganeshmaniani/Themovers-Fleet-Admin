import 'package:equatable/equatable.dart';

class PremiumEntities extends Equatable {
  final String bookingId;
  final int userId;
  final String bookingDate;
  final String customerId;
  final int serviceType;
  final String vehicleType;
  final double amount;
  final int stairCarryCount;
  final int longPushType;
  final String tailGate;
  final double vehicleAmount;
  final double tailgateAmount;
  final double stairCarryAmount;
  final double longPushAmount;
  final double totalAmount;

  const PremiumEntities(
      {required this.bookingId,
      required this.bookingDate,
      required this.userId,
      required this.customerId,
      required this.serviceType,
      required this.vehicleType,
      required this.amount,
      required this.stairCarryCount,
      required this.longPushType,
      required this.tailGate,
      required this.vehicleAmount,
      required this.tailgateAmount,
      required this.stairCarryAmount,
      required this.longPushAmount,
      required this.totalAmount});

  @override
  List<Object> get props {
    return [
      bookingId,
      userId,
      bookingDate,
      customerId,
      serviceType,
      vehicleType,
      amount,
      stairCarryCount,
      longPushType,
      tailGate,
      vehicleAmount,
      tailgateAmount,
      stairCarryAmount,
      longPushAmount,
      totalAmount,
    ];
  }

  @override
  bool get stringify => true;

  PremiumEntities copyWith({
    final String? bookingId,
    final String? bookingDate,
    final int? userId,
    final String? customerId,
    final int? serviceType,
    final String? vehicleType,
    final double? amount,
    final int? stairCarryCount,
    final int? longPushType,
    final String? tailGate,
    final double? vehicleAmount,
    final double? tailgateAmount,
    final double? stairCarryAmount,
    final double? longPushAmount,
    final double? totalAmount,
  }) {
    return PremiumEntities(
      bookingId: bookingId ?? this.bookingId,
      userId: userId ?? this.userId,
      bookingDate: bookingDate ?? this.bookingDate,
      customerId: customerId ?? this.customerId,
      serviceType: serviceType ?? this.serviceType,
      vehicleType: vehicleType ?? this.vehicleType,
      amount: amount ?? this.amount,
      stairCarryCount: stairCarryCount ?? this.stairCarryCount,
      longPushType: longPushType ?? this.longPushType,
      tailGate: tailGate ?? this.tailGate,
      vehicleAmount: vehicleAmount ?? this.vehicleAmount,
      tailgateAmount: tailgateAmount ?? this.tailgateAmount,
      stairCarryAmount: stairCarryAmount ?? this.stairCarryAmount,
      longPushAmount: longPushAmount ?? this.longPushAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
