import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'i_local_storage_service.dart';
import '../logging/i_logging_service.dart';


@Singleton(as: ILocalStorageService)
class SecureLocalStorageService implements ILocalStorageService {
  final FlutterSecureStorage _secureLocalStorage;
  final ILoggingService _loggingService;

  SecureLocalStorageService(this._secureLocalStorage, this._loggingService) {
    _loggingService.init(runtimeType.toString());
  }

  Future<T?> _load<T>(String key,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      String? jsonString = await _secureLocalStorage.read(key: key);
      if (jsonString == null) {
        return null;
      }
      return fromJson(jsonDecode(jsonString));
    } catch (e, s) {
      _loggingService.error('failed getting current ${(T).toString()}', e, s);
      return null;
    }
  }

  Future<T> _save<T>(String key,
      T object,
      T Function(Map<String, dynamic>) fromJson,) async {
    await _secureLocalStorage.write(key: key, value: jsonEncode(object));
    return (await _load<T>(key, fromJson))!;
  }

  Future<bool> _clear(String key) async {
    return await _secureLocalStorage.delete(key: key).then((value) => true).catchError((error, stackTrace) {
      _loggingService.error('error while deleting "$key"', error, stackTrace);
      return false;
    });
  }
}

abstract class Keys {

}