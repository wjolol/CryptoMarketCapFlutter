import 'package:crypto_market_cap_flutter/Models/crypto_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/Repositories/crypto_detail_repository.dart';

class CryptoDetailViewModel extends ChangeNotifier {

  CryptoDetailViewModel({
    required this.repository,  
  });

  final CryptoDataRepository repository;

  CryptoDetailModel? _cryptoDetail;
  

  Future<void> fetchData(String cryptoId) async {
    _cryptoDetail = await repository.fetchCryptoDetail(cryptoId);
    notifyListeners();
  }

  String getDescription() {
    if (_cryptoDetail?.description.text == null || _cryptoDetail?.description.text.trim() == "") {
      return "Descrizione non disponibile";
    } else {
      return _cryptoDetail?.description.text ?? "-";
    }
  }

  void eraseDescription() {
    _cryptoDetail?.description.text = "";
  }
}