part of 'dependencies.dart';

Future<void> injectBlocs() async {
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        signInUserUseCase: sl<SignInUserUseCase>(),
        signUpUserUseCase: sl<SignUpUserUseCase>(),
        signOutUserUseCase: sl<SignOutUserUseCase>(),
        sendVerificationCodeUseCase: sl<SendVerificationCodeUseCase>(),
        verifyPhoneUseCase: sl<VerifyPhoneUseCase>(),
        updateUserUseCase: sl<UpdateUserUseCase>(),
        insertUserUseCase: sl<InsertUserUseCase>(),
      ));
}
