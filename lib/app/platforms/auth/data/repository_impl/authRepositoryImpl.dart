import 'package:dartz/dartz.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/firebase_auth_page_data_sources.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/firebase_auth_page_data_sources_impl.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/supabase_remote_data_source.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/supabase_remote_data_source_impl.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/models/user.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/repository/auth_repository.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/error_handler/error_handler.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/utils/authResult.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource _authRemoteDataSourceImpl;
  final SupabaseAuthDataSource _supabaseAuthDataSourceImpl;

  AuthRepositoryImpl(
      this._supabaseAuthDataSourceImpl, this._authRemoteDataSourceImpl);

  @override
  Future<Either<ErrorState, void>> insertUser(UserModel userModel) async {
    return await ErrorHandler.callSupabase(
            () => _supabaseAuthDataSourceImpl.insertUserToDb(userModel), (value) {});
  }

  @override
  Future<Either<ErrorState, void>> updateUser(UserModel userModel, String uid) async {
    return await ErrorHandler.callSupabase(
            () => _supabaseAuthDataSourceImpl.updateUser(userModel, uid), (value) {});
  }

  @override
  Future<Either<ErrorState, void>> sendVerificationCode(
      String phoneNumber, Function(String) codeSent) async {
    return await ErrorHandler.callFirebasePhoneAuth<void>(
          () => _authRemoteDataSourceImpl.sendVerificationCode(phoneNumber, codeSent),
    );
  }

  @override
  Future<Either<ErrorState, String?>> signInWithEmailPassword(
      String email, String password) async {
    return await ErrorHandler.callFirebaseAuth<String?>(
          () => _authRemoteDataSourceImpl.signInWithEmailAndPassword(email, password),
    );
  }

  @override
  Future<Either<ErrorState, void>> signOut() async {
    return await ErrorHandler.callFirebaseAuth<void>(
          () => _authRemoteDataSourceImpl.signOut(),
    );
  }

  @override
  Future<Either<ErrorState, String?>> signUpWithEmailPassword(
      String email, String password) async {
    return await ErrorHandler.callFirebaseAuth<String?>(
          () => _authRemoteDataSourceImpl.signUpWithEmailPassword(email, password),
    );
  }

  @override
  Future<Either<ErrorState, String?>> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    return await ErrorHandler.callFirebasePhoneAuth<String?>(
          () => _authRemoteDataSourceImpl.verifyPhoneNumber(verificationId, smsCode),
    );
  }
}
