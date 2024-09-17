import 'package:dartz/dartz.dart';
import '../../../../shared/core/utils/authResult.dart';
import '../../data/repository_impl/authRepositoryImpl.dart';
import '../repository/auth_repository.dart';

class SignOutUserUseCase {
  final AuthRepository authRepositoryImpl;

  SignOutUserUseCase(this.authRepositoryImpl);

  Future<Either<ErrorState, void>> call() async {
    return await authRepositoryImpl.signOut();
  }
}
