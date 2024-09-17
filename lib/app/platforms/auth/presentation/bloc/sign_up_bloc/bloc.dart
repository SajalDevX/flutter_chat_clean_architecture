import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/presentation/bloc/sign_up_bloc/states.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';
import '../../../domain/repository/auth_repository.dart';
import 'events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SendVerificationCodeRequested>(_onSendVerificationCodeRequested);
    on<VerifyPhoneNumberRequested>(_onVerifyPhoneNumberRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  // Handle email/password signup
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Either<ErrorState, String?> result = await authRepository
        .signUpWithEmailPassword(event.email, event.password);

    result.fold(
          (error) => emit(AuthError(error.clientError.toString())), // Error handling
          (userId) => emit(Authenticated(userId)),   // Success
    );
  }

  // Handle sending verification code to phone number
  Future<void> _onSendVerificationCodeRequested(
      SendVerificationCodeRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Either<ErrorState, void> result = await authRepository.sendVerificationCode(
      event.phoneNumber,
          (verificationId) {
        emit(PhoneVerificationCodeSent(verificationId));
      },
    );

    result.fold(
          (error) => emit(AuthError(error.clientError.toString())),
          (_) => {}, // Handled with the callback function
    );
  }

  // Handle verifying the phone number using the received SMS code
  Future<void> _onVerifyPhoneNumberRequested(
      VerifyPhoneNumberRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Either<ErrorState, String?> result = await authRepository.verifyPhoneNumber(
      event.verificationId,
      event.smsCode,
    );

    result.fold(
          (error) => emit(AuthError(error.clientError.toString())),
          (userId) => emit(Authenticated(userId)),
    );
  }

  // Handle sign-out
  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Either<ErrorState, void> result = await authRepository.signOut();

    result.fold(
          (error) => emit(AuthError(error.clientError.toString())),
          (_) => emit(SignedOut()), // Successful sign-out
    );
  }
}
