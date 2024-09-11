import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/data_sources/supabase_remote_data_source.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/data/models/user.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/backend_controller/db_controller/db_tables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDataSourceImpl implements SupabaseAuthDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> insertUserToDb(UserModel userModel) async {
    await supabase.from(DbTables.usersTable).insert(userModel.toJson());
  }

  @override
  Future<void> updateUser(UserModel userModel, String uid) async {
    await supabase
        .from(DbTables.usersTable)
        .update(userModel.toJson())
        .match({'id': uid});
  }
}
