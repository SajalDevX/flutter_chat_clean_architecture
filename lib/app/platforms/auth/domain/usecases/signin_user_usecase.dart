import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/repository_impl/authRepositoryImpl.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';

class SignInUserUseCase {
  final AuthRepositoryImpl authRepository;

  SignInUserUseCase(this.authRepository);

  Future<Either<ErrorState, String?>> call(
      {required String email, required String password}) async {
    return await authRepository.signInWithEmailPassword(email, password);
  }
}
