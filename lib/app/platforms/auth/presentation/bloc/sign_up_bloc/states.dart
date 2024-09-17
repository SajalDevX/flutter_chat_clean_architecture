// auth_state.dart
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// State during any loading process (signup, phone verification, etc.)
class AuthLoading extends AuthState {}

// State when user is authenticated
class Authenticated extends AuthState {
  final String? userId;

  const Authenticated(this.userId);

  @override
  List<Object?> get props => [userId];
}

// State when phone verification code is sent
class PhoneVerificationCodeSent extends AuthState {
  final String verificationId;

  const PhoneVerificationCodeSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

// Error state
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// State when the user has signed out
class SignedOut extends AuthState {}
