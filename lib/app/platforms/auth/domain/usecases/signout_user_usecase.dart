import 'package:dartz/dartz.dart';
import '../../../../shared/core/utils/authResult.dart';
import '../../data/repository_impl/authRepositoryImpl.dart';

class SignOutUserUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  SignOutUserUseCase(this.authRepositoryImpl);

  Future<Either<ErrorState, void>> call() async {
    return await authRepositoryImpl.signOut();
  }
}
