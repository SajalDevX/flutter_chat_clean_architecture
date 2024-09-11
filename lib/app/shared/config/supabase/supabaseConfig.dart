import 'package:supabase/supabase.dart';

class SupabaseCredentials{
  static const String APIKEY = '';
  static const String APIURL = '';
  static SupabaseClient supabaseClient = SupabaseClient(APIURL, APIKEY);
}