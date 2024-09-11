import 'package:dartz/dartz.dart';

import '../../../../shared/core/utils/authResult.dart';
import '../../data/models/user.dart';
import '../../data/repository_impl/authRepositoryImpl.dart';

class UpdateUserUseCase {
  final AuthRepositoryImpl authPageRepository;

  UpdateUserUseCase(this.authPageRepository);

  Future<Either<ErrorState, void>> call(
      {required UserModel user, required String uid}) async {
    return await authPageRepository.updateUser(user, uid);
  }
}
