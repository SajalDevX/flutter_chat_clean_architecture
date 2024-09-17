import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/repository_impl/authRepositoryImpl.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';

import '../repository/auth_repository.dart';

class SignUpUserUseCase {
  final AuthRepository authRepository;

  SignUpUserUseCase(this.authRepository);

  Future<Either<ErrorState, String?>> call(
      {required String email, required String password}) async {
    return await authRepository.signUpWithEmailPassword(email, password);
  }
}
