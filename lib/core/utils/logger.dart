import 'package:logger/logger.dart';

class Log {
  const Log._();

  static var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static t(String message) {
    logger.t(message);
  }

  static d(String message) {
    logger.d(message);
  }

  static i(String message) {
    logger.i(message);
  }

  static w(String message) {
    logger.w(message);
  }

  static e(String title, {required String error}) {
    logger.e(title, error: error);
  }

  static f(String title, {required String error}) {
    logger.f("What a fatal log", error: error, stackTrace: StackTrace.current);
  }
}
