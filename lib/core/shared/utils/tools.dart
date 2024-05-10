import 'package:flutter/foundation.dart';

/// Log and send to crashlytics
/// [message] Custom message to be printed
Future<void> logger(dynamic e, [StackTrace? stack, String? message]) async {
  if (message != null && message.isNotEmpty) debugPrint(message);
  debugPrint("$e\n$stack");
  try {
    if (!kDebugMode) {
      // await FirebaseCrashlytics.instance.recordError(e, stack, reason: message, printDetails: false);
    }
  } catch (ex, stk) {
    debugPrint("Could not use Crashlytics:\n$e\n$stk");
  }
}

/// Return name initials from full name
String getNameInitials(String? name) {
  if (name?.isEmpty ?? true) {
    return "";
  }
  var initials = name!.length > 2 ? name.trim().substring(0, 2) : name;
  var names = name.trim().split(" ");
  if (names.length > 1) {
    initials = name[0] + names[names.length - 1][0];
  }
  return initials.toUpperCase();
}
