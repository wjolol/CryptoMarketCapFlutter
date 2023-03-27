import 'dart:collection';

import 'package:crypto_market_cap_flutter/Models/filter.dart';
import 'package:crypto_market_cap_flutter/Repositories/main_page_repository.dart';
import 'package:flutter/material.dart';
import '../Models/crypto_data_model.dart';

class MainViewModel extends ChangeNotifier {

  MainViewModel({
    required this.mainPageRepo,  
  });

  final MainPageRepository mainPageRepo;

  List<CryptoDataModel> _cryptoDataList = [];
  bool isLoading = false;

  UnmodifiableListView<CryptoDataModel> get cryptoDataList {
    return UnmodifiableListView(_cryptoDataList);
  }

  Future<void> fetchData({CurrencyFilter currency = CurrencyFilter.eur, OrderFilter order = OrderFilter.marketCapDesc}) async {
    isLoading = true;
    _cryptoDataList = await mainPageRepo.fetchData(currency: currency, order: order);
    isLoading = false;
    notifyListeners();
  }
}