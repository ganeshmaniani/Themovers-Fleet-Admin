import 'dart:io';

import 'package:equatable/equatable.dart';

class WalletTopUpEntities extends Equatable {
  final String paymentMode;
  final String amount;
  final File paymentAttachment;

  const WalletTopUpEntities({
    required this.paymentMode,
    required this.amount,
    required this.paymentAttachment,
  });

  @override
  List<Object> get props {
    return [paymentMode, amount, paymentAttachment];
  }

  @override
  bool get stringify => true;

  WalletTopUpEntities copyWith({
    final String? paymentMode,
    final String? amount,
    final File? paymentAttachment,
  }) {
    return WalletTopUpEntities(
      paymentMode: paymentMode ?? this.paymentMode,
      amount: amount ?? this.amount,
      paymentAttachment: paymentAttachment ?? this.paymentAttachment,
    );
  }
}
