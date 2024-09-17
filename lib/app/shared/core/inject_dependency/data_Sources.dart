import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../../platforms/auth/data/data_sources/firebase_auth_page_data_sources.dart';
import '../../../platforms/auth/data/data_sources/firebase_auth_page_data_sources_impl.dart';
import '../../../platforms/auth/data/data_sources/supabase_remote_data_source.dart';
import '../../../platforms/auth/data/data_sources/supabase_remote_data_source_impl.dart';
final sl = GetIt.instance;

Future<void> injectDataSources() async {
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton<SupabaseAuthDataSource>(() => SupabaseAuthDataSourceImpl());
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(() => FirebaseAuthRemoteDataSourceImpl(firebaseAuth));
}
