import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/models/user.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';

abstract class AuthRepository {
  Future<Either<ErrorState, String?>> signInWithEmailPassword(
      String email, String password);

  Future<Either<ErrorState, String?>> signUpWithEmailPassword(
      String email, String password);

  Future<Either<ErrorState, void>> sendVerificationCode(
      String phoneNumber, Function(String) codeSent);

  Future<Either<ErrorState, String?>> verifyPhoneNumber(
      String verificationId, String smsCode);

  Future<Either<ErrorState, void>> insertUser(UserModel userModel);

  Future<Either<ErrorState, void>> updateUser(UserModel userModel,String uid);

  Future<Either<ErrorState, void>> signOut();
}
