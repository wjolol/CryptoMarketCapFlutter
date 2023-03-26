import 'package:crypto_market_cap_flutter/Models/crypto_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;

abstract class MainPageRepository {
  Future<List<CryptoDataModel>> fetchData();
}

class MainPageRepositoryImpl extends MainPageRepository {

  @override
  Future<List<CryptoDataModel>> fetchData() async {
    Uri url = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false");
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




