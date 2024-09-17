import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/presentation/pages/onboarding_screen.dart';
import 'package:flutter_chat_clean_architecture/app/shared/core/inject_dependency/dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/platforms/auth/presentation/bloc/sign_up_bloc/bloc.dart';
import 'app/shared/config/supabase/supabaseConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseCredentials.APIURL,
    anonKey: SupabaseCredentials.APIKEY,
  );
  await Firebase.initializeApp();

  // Initialize your dependency injection (GetIt)
  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),  // Get AuthBloc from GetIt (service locator)
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
