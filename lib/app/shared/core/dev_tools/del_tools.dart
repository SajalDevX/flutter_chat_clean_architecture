import 'package:talker/talker.dart';

class SupabaseLogger extends TalkerLog {
  SupabaseLogger(String super.message, StackTrace? stackTrace, error)
      : super(stackTrace: stackTrace, exception: error);

  /// Your custom log title
  @override
  String get title => 'Supabase';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..red();
}
