import 'package:flutter/material.dart';
import 'package:flutter_chat_clean_architecture/app/platforms/auth/presentation/pages/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/shared/config/supabase/supabaseConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseCredentials.APIURL,
    anonKey: SupabaseCredentials.APIKEY,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}
