import 'dart:convert';
import 'package:crypto_market_cap_flutter/Models/crypto_detail_model.dart';
import 'package:http/http.dart' show get;

abstract class CryptoDataRepository {
  Future<CryptoDetailModel?> fetchCryptoDetail(String cryptoId);
}

class CryptoDataRepositoryImpl extends CryptoDataRepository {

  @override
  Future<CryptoDetailModel?> fetchCryptoDetail(String cryptoId) async {
    Uri url = Uri.parse("https://api.coingecko.com/api/v3/coins/$cryptoId");
    final responseData = await get(url);
    if(responseData.statusCode == 200){
      final data = jsonDecode(responseData.body);
      return CryptoDetailModel.fromJson(data);
    } else {
      return null;
    }
  }
}