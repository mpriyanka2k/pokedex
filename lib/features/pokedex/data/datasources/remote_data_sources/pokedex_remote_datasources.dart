import 'dart:convert';

import 'package:pokedex/core/hive/hive_services.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/core/network/api_service.dart';
import 'package:pokedex/core/utils/encryption_service.dart';
import 'package:pokedex/features/pokedex/data/mapper/pokedex_detail_mapper.dart';
import 'package:pokedex/features/pokedex/data/mapper/pokedex_mapper.dart';
import 'package:pokedex/features/pokedex/data/model/pokedex_model.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_detail_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

class PokedexRemoteDatasources {
 
  ApiService apiService;
  HiveService hiveService;
  EncryptionService encryptionService = EncryptionService();
  

  PokedexRemoteDatasources(this.apiService,this.hiveService);

  Future<ApiResponse> getPokedexList() async {
    try {
      final data = await apiService.request('', method: HttpMethod.get);
      if (data is ApiSuccess) {
        var pokedex = data.data;
        // hiveService.clearBox('pokedex');
        final pokemonDataList = pokedex['results'].map((result) {

          print("Priyanka Initial data = $result");


          final encryptedPayload = encryptionService.encryptAES(result);

          print("Priyanka Encrypted Payload:");
          print("Priyanka  Encrypted : $encryptedPayload");
          

          final decryptedJsonString = encryptionService.decryptAES(
            encryptedPayload,
          );
          final decodedJson = jsonDecode(decryptedJsonString);

          print("Priyanka Decrypted JSON:");
          print("Priyanka decodedJson =$decodedJson");

          return PokedexMapper.toPokemonEntity(Result.fromJson(decodedJson));
        }).toList();

        return ApiSuccess(pokemonDataList, statusCode: data.statusCode);
      } else if (data is ApiError) {
        return ApiError(data.message, statusCode: data.statusCode);
      }

      return ApiError('Unknown error', statusCode: 0);
    } catch (e) {
      print("errors = $e");
      return ApiError('Unknown error', statusCode: 0);
    }
  }

  Future<ApiResponse> pokedexDetail(String id) async {
    try {
      final data = await apiService.request("/$id", method: HttpMethod.get);
      if (data is ApiSuccess) {
        var pokemonDetail = PokedexDetailMapper.toPokemonEntity(
          PokemonDetail.fromJson(data.data),
        );
        return ApiSuccess(pokemonDetail, statusCode: data.statusCode);
      } else if (data is ApiError) {
        return ApiError(data.message, statusCode: data.statusCode);
      }
      return ApiError('Unknown error', statusCode: 0);
    } catch (e) {
      return ApiError('Unknown error', statusCode: 0);
    }
  }
}
