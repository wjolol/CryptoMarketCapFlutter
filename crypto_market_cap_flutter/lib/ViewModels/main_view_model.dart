import 'dart:collection';

import 'package:crypto_market_cap_flutter/Repositories/main_page_repository.dart';
import 'package:flutter/material.dart';
import '../Models/crypto_data_model.dart';

class MainViewModel extends ChangeNotifier {

  MainViewModel({
    required this.mainPageRepo,  
  });

  final MainPageRepository mainPageRepo;

  List<CryptoDataModel> _cryptoDataList = [];

  UnmodifiableListView<CryptoDataModel> get cryptoDataList {
    return UnmodifiableListView(_cryptoDataList);
  }

  Future<void> fetchData() async {
    _cryptoDataList = await mainPageRepo.fetchData();
    notifyListeners();
  }
}