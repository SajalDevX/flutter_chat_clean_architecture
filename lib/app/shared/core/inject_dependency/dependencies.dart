import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/insert_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/send_verification_code_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signin_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signout_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/signup_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/update_user_usecase.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/domain/usecases/verify_phone_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../../platforms/auth/data/data_sources/firebase_auth_page_data_sources.dart';
import '../../../platforms/auth/data/data_sources/supabase_remote_data_source.dart';
import '../../../platforms/auth/data/repository_impl/authRepositoryImpl.dart';
import '../../../platforms/auth/domain/repository/auth_repository.dart';
import '../../../platforms/auth/presentation/bloc/sign_up_bloc/bloc.dart';
import 'data_Sources.dart';

part 'inject_blocs.dart';


part 'usecases.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await Firebase.initializeApp();

  // Register Data Sources
  injectDataSources();

  // Register Repositories
  injectRepositories();

  // Register Use Cases
  injectUseCases();
  injectBlocs();
}

Future<void> injectRepositories() async {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    sl<SupabaseAuthDataSource>(),
    sl<FirebaseAuthRemoteDataSource>(),
  ));
}



Future<void> clearAndReinitializeDependencies() async {
  await sl.reset();
  await initializeDependencies();
}

Future<AuthBloc> resetAuthPageBlocInstance() async {
  if (sl.isRegistered<AuthBloc>()) {
    await sl.unregister<AuthBloc>();
  }
  sl.registerSingleton<AuthBloc>(AuthBloc(
    signInUserUseCase: sl<SignInUserUseCase>(),
    signUpUserUseCase: sl<SignUpUserUseCase>(),
    signOutUserUseCase: sl<SignOutUserUseCase>(),
    sendVerificationCodeUseCase: sl<SendVerificationCodeUseCase>(),
    verifyPhoneUseCase: sl<VerifyPhoneUseCase>(),
    updateUserUseCase: sl<UpdateUserUseCase>(),
    insertUserUseCase: sl<InsertUserUseCase>(),
  ));
  return sl<AuthBloc>();
}
