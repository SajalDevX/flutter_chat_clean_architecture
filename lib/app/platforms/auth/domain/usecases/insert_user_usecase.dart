import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/repository_impl/authRepositoryImpl.dart';

import '../../../../shared/core/utils/authResult.dart';
import '../../data/models/user.dart';
import '../repository/auth_repository.dart';

class InsertUserUseCase {
  final AuthRepository authPageRepository;

  InsertUserUseCase(this.authPageRepository);

  Future<Either<ErrorState, void>> call({required UserModel user}) async {
    return await authPageRepository.insertUser(user);
  }
}