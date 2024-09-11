import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/firebase_auth_page_data_sources.dart';

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    return user?.uid;
  }

  @override
  Future<String?> signUpWithEmailPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    return user?.uid;
  }

  @override
  Future<void> sendVerificationCode(
      String phoneNumber, Function(String p1) codeSent) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String?> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    return user?.uid;
  }
}
