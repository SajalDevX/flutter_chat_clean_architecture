// auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SendVerificationCodeRequested extends AuthEvent {
  final String phoneNumber;

  const SendVerificationCodeRequested({
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyPhoneNumberRequested extends AuthEvent {
  final String verificationId;
  final String smsCode;

  const VerifyPhoneNumberRequested({
    required this.verificationId,
    required this.smsCode,
  });

  @override
  List<Object?> get props => [verificationId, smsCode];
}

class SignOutRequested extends AuthEvent {}
