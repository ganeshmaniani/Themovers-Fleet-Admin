import 'package:equatable/equatable.dart';

class EmailOtpEntities extends Equatable {
  final String email;
  final String otp;
  const EmailOtpEntities({required this.email, required this.otp});

  @override
  List<Object> get props {
    return [email, otp];
  }

  @override
  bool get stringify => true;

  EmailOtpEntities copyWith({final String? email, final String? otp}) {
    return EmailOtpEntities(email: email ?? this.email, otp: otp ?? this.otp);
  }
}
