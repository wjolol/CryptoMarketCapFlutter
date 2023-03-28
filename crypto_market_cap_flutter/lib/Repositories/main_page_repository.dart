import 'package:crypto_market_cap_flutter/Models/crypto_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;

abstract class MainPageRepository {
  Future<List<CryptoDataModel>> fetchData({required String currency, required String order});
}

class MainPageRepositoryImpl extends MainPageRepository {

  @override
  Future<List<CryptoDataModel>> fetchData({required String currency, required String order}) async {
    
    Uri url = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currency&order=$order&per_page=100&page=1&sparkline=false");
    final responseData = await get(url);
    List<CryptoDataModel> cryptoDataList = [];
    if(responseData.statusCode == 200){
      final data = jsonDecode(responseData.body);
      //print(data);
      for(Map cryptoData in data) {
        cryptoDataList.add(CryptoDataModel.fromJson(cryptoData));
      }
    }
    return cryptoDataList;
  }
}
