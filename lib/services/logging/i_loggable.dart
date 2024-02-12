import 'i_logging_service.dart';

abstract class ILoggable {
  final ILoggingService _loggingService;

  ILoggable(this._loggingService) {
    _loggingService.init(runtimeType.toString());
  }
}
