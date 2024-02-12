import 'dart:developer' as developer;

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

class DeveloperLogAppender extends BaseLogAppender {
  final List<LogRecord> _logRecordList = [];
  List<LogRecord> get recordList => _logRecordList;

  DeveloperLogAppender({LogRecordFormatter? formatter}) : super(formatter ?? const DefaultLogRecordFormatter());

  @override
  void handle(LogRecord record) {
    _logRecordList.add(record);
    developer.log(
      record.message,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  }
}