import 'package:flutter/foundation.dart';

/// Log and send to crashlytics
/// [message] Custom message to be printed
Future<void> logger(dynamic e, [StackTrace? stack, String? message]) async {
  if (message != null && message.isNotEmpty) print(message);
  print("$e\n$stack");
  try {
    if (!kDebugMode) {
      // await FirebaseCrashlytics.instance.recordError(e, stack, reason: message, printDetails: false);
    }
  } catch (ex, stk) {
    print("Could not use Crashlytics:\n$e\n$stk");
  }
}
