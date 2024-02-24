import '../../../model/tokens_dto.dart';

abstract class ILocalStorageService {
  Future<TokensDto?> loadTokens();
  Future<TokensDto> saveTokens(TokensDto tokens);
  Future<bool> clearTokens();
}