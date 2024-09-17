part of 'dependencies.dart';

Future<void> injectUseCases() async {
  sl.registerLazySingleton<SignInUserUseCase>(() => SignInUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SignUpUserUseCase>(() => SignUpUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SignOutUserUseCase>(() => SignOutUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SendVerificationCodeUseCase>(() => SendVerificationCodeUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<VerifyPhoneUseCase>(() => VerifyPhoneUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<UpdateUserUseCase>(() => UpdateUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<InsertUserUseCase>(() => InsertUserUseCase(sl<AuthRepository>()));

}