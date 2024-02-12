import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'i_logging_service.dart';

@Injectable(as: ILoggingService)
class LoggingService implements ILoggingService {
  late final Logger _appLogger;

  @override
  String get loggerName => _appLogger.name;

  @override
  ILoggingService init(String loggerName) {
    _appLogger = Logger(loggerName);
    return this;
  }

  @override
  void debug(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.config(message, error, stackTrace);
  }

  @override
  void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.severe(message, error, stackTrace);
  }

  @override
  void fatal(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.shout(message, error, stackTrace);
  }

  @override
  void info(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.info(message, error, stackTrace);
  }

  @override
  void verbose(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.fine(message, error, stackTrace);
  }

  @override
  void trace(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.finer(message, error, stackTrace);
  }

  @override
  void warning(Object? message, [Object? error, StackTrace? stackTrace]) {
    _appLogger.warning(message, error, stackTrace);
  }
}