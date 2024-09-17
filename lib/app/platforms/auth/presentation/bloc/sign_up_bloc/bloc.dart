import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/insert_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/send_verification_code_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signin_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signout_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signup_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/update_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/verify_phone_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/presentation/bloc/sign_up_bloc/states.dart';
import 'package:logger/logger.dart';
import '../../../../../shared/core/utils/authResult.dart';
import '../../../domain/repository/auth_repository.dart';
import 'events.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUserUseCase signUpUserUseCase;
  final SignInUserUseCase signInUserUseCase;
  final SendVerificationCodeUseCase sendVerificationCodeUseCase;
  final VerifyPhoneUseCase verifyPhoneUseCase;
  final SignOutUserUseCase signOutUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final InsertUserUseCase insertUserUseCase;

  final Logger _logger = Logger();

  AuthBloc({
    required this.signUpUserUseCase,
    required this.signInUserUseCase,
    required this.sendVerificationCodeUseCase,
    required this.verifyPhoneUseCase,
    required this.signOutUserUseCase,
    required this.updateUserUseCase,
    required this.insertUserUseCase,
  }) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SendVerificationCodeRequested>(_onSendVerificationCodeRequested);
    on<VerifyPhoneNumberRequested>(_onVerifyPhoneNumberRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  // Handle email/password signup
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    _logger.d('Handling SignUpRequested with email: ${event.email}');
    emit(AuthLoading());

    Either<ErrorState, String?> result =
    await signUpUserUseCase(email: event.email, password: event.password);

    result.fold(
          (error) {
        _logger.e('SignUp error: ${error.clientError}');
        emit(AuthError(error.clientError.toString()));
      },
          (userId) {
        _logger.d('SignUp success with userId: $userId');
        emit(Authenticated(userId));
      },
    );
  }

  Future<void> _onSendVerificationCodeRequested(
      SendVerificationCodeRequested event, Emitter<AuthState> emit) async {
    _logger.d('Handling SendVerificationCodeRequested with phoneNumber: ${event.phoneNumber}');
    emit(AuthLoading());

    Either<ErrorState, void> result = await sendVerificationCodeUseCase(
      phoneNumber: event.phoneNumber,
      codeSent: (verificationId) {
        _logger.d('Verification code sent with verificationId: $verificationId');
        emit(PhoneVerificationCodeSent(verificationId));
      },
    );

    result.fold(
          (error) {
        _logger.e('SendVerificationCode error: ${error.clientError}');
        emit(AuthError(error.clientError.toString()));
      },
          (_) {
        _logger.d('SendVerificationCode success');
        // Successfully handled in the callback
      },
    );
  }

  // Handle verifying the phone number using the received SMS code
  Future<void> _onVerifyPhoneNumberRequested(
      VerifyPhoneNumberRequested event, Emitter<AuthState> emit) async {
    _logger.d('Handling VerifyPhoneNumberRequested with verificationId: ${event.verificationId}');
    emit(AuthLoading());

    Either<ErrorState, String?> result = await verifyPhoneUseCase(
      verificationId: event.verificationId,
      smsCode: event.smsCode,
    );

    result.fold(
          (error) {
        _logger.e('VerifyPhoneNumber error: ${error.clientError}');
        emit(AuthError(error.clientError.toString()));
      },
          (userId) {
        _logger.d('VerifyPhoneNumber success with userId: $userId');
        emit(Authenticated(userId));
      },
    );
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    _logger.d('Handling SignOutRequested');
    emit(AuthLoading());

    Either<ErrorState, void> result = await signOutUserUseCase();

    result.fold(
          (error) {
        _logger.e('SignOut error: ${error.clientError}');
        emit(AuthError(error.clientError.toString()));
      },
          (_) {
        _logger.d('SignOut success');
        emit(SignedOut());
      },
    );
  }
}
