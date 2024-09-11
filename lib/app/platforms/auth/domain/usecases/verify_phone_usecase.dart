import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/repository_impl/authRepositoryImpl.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';

class VerifyPhoneUseCase {
  final AuthRepositoryImpl authRepository;

  VerifyPhoneUseCase(this.authRepository);

  Future<Either<ErrorState, String?>> call(
      {required String verificationId, required String smsCode}) async {
    return await authRepository.verifyPhoneNumber(verificationId, smsCode);
  }
}
