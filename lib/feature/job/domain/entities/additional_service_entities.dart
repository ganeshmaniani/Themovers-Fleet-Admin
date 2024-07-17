import 'package:equatable/equatable.dart';

class AdditionalServiceEntities extends Equatable {
  final String bookingId;
  final String addOnAmount;
  final String service;
  final String description;

  const AdditionalServiceEntities(
      {required this.bookingId,
      required this.addOnAmount,
      required this.service,
      required this.description});

  @override
  List<Object> get props {
    return [bookingId, addOnAmount, service, description];
  }

  @override
  bool get stringify => true;

  AdditionalServiceEntities copyWith({
    final String? bookingId,
    final String? addOnAmount,
    final String? description,
    final String? service,
  }) {
    return AdditionalServiceEntities(
      bookingId: bookingId ?? this.bookingId,
      addOnAmount: addOnAmount ?? this.addOnAmount,
      description: description ?? this.description,
      service: service ?? this.service,
    );
  }
}
