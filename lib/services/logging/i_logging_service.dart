abstract class ILoggingService {
  String get loggerName;

  ILoggingService init(String loggerName);

  void trace(Object? message, [Object? error, StackTrace? stackTrace]);

  void verbose(Object? message, [Object? error, StackTrace? stackTrace]);

  void debug(Object? message, [Object? error, StackTrace? stackTrace]);

  void info(Object? message, [Object? error, StackTrace? stackTrace]);

  void warning(Object? message, [Object? error, StackTrace? stackTrace]);

  void error(Object? message, [Object? error, StackTrace? stackTrace]);

  void fatal(Object? message, [Object? error, StackTrace? stackTrace]);
}
