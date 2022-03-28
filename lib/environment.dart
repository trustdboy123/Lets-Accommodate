import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get FILE_NAME =>
      kReleaseMode ? ".env.production" : ".env.development";

  static String get PAYSTACK_PUBLIC_KEY {
    var key = dotenv.env['IS_PAYSTACK_LIVE'] == "true"
        ? dotenv.env['PAYSTACK_PUBLIC_LIVE_KEY'] ?? ""
        : dotenv.env['PAYSTACK_PUBLIC_TEST_KEY'] ?? "";
    print("KEy: $key");
    return key;
  }
}
