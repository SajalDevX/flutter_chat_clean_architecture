

abstract class FirebaseAuthRemoteDataSource {
  Future<String?> signInWithEmailAndPassword(
      String email, String password);

  Future<String?> signUpWithEmailPassword(
      String email, String password);

  Future<void> signOut();

  Future<void> sendVerificationCode(
      String phoneNumber, Function(String) codeSent);

  Future<String?> verifyPhoneNumber(
      String verificationId, String smsCode);
}
