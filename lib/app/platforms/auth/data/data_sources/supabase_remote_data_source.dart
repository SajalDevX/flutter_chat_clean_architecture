import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/models/user.dart';

abstract class SupabaseAuthDataSource{
  Future<void> insertUserToDb(UserModel userModel);
  Future<void> updateUser(UserModel userModel, String uid);
}