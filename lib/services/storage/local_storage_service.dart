import 'dart:convert';

import 'package:epro_frontend/model/tokens_dto.dart';
import 'package:epro_frontend/services/logging/i_logging_service.dart';
import 'package:epro_frontend/services/storage/i_local_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: ILocalStorageService)
class LocalStorageService implements ILocalStorageService{
  final SharedPreferences _prefs;
  final ILoggingService _loggingService;

  LocalStorageService(this._prefs, this._loggingService){
    _loggingService.init(runtimeType.toString());
  }

  Future<T?> _load<T>(String key,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      String? jsonString = _prefs.getString(key);
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
    await _prefs.setString(key, jsonEncode(object));
    return (await _load<T>(key, fromJson))!;
  }

  Future<bool> _clear(String key) async {
    return await _prefs.remove(key).then((value) => true).catchError((error, stackTrace) {
      _loggingService.error('error while deleting "$key"', error, stackTrace);
      return false;
    });
  }

  @override
  Future<TokensDto?> loadTokens() async{
    return await _load(Keys.tokens, TokensDto.fromJson);
  }

  @override
  Future<TokensDto> saveTokens(TokensDto tokens) async {
    return await _save(Keys.tokens, tokens, TokensDto.fromJson);
  }

  @override
  Future<bool> clearTokens() async {
    return await _clear(Keys.tokens);
  }
}

abstract class Keys {
  static const tokens = 'tokens';
}