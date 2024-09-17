import 'package:dartz/dartz.dart';
import '../../../../shared/core/utils/authResult.dart';
import '../../data/repository_impl/authRepositoryImpl.dart';
import '../repository/auth_repository.dart';

class SendVerificationCodeUseCase {
  final AuthRepository authRepositoryImpl;

  SendVerificationCodeUseCase(this.authRepositoryImpl);

  Future<Either<ErrorState, void>> call({
    required String phoneNumber,
    required Function(String) codeSent,
  }) async {
    return await authRepositoryImpl.sendVerificationCode(phoneNumber, codeSent);
  }
}
