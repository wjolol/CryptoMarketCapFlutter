import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filters extends ChangeNotifier {

  final String key = "selectedFilters";
  SharedPreferences? _prefs;
  
  late CurrencyFilter _currencyFilter;
  late OrderFilter _orderFilter;

  CurrencyFilter get currencyFilter => _currencyFilter;
  OrderFilter get orderFilter => _orderFilter;
  set setCurrencyFilter(CurrencyFilter filter) => _currencyFilter = filter;
  set setOrderFilter(OrderFilter filter) => _orderFilter = filter;

  Filters() {
    _currencyFilter = CurrencyFilter.eur;
    _orderFilter = OrderFilter.marketCapDesc;
  }

  Future<void> _initiateprefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> loadprefs() async {
    await _initiateprefs();
    if (_prefs != null && _prefs!.getStringList(key) != null) {
      List<String> filters = _prefs!.getStringList(key)!;
      _currencyFilter = _stringToCurrencyFilter(filters[0]);
      _orderFilter = _stringTosetOrderFilter(filters[1]);
      notifyListeners();
    }
  }

  Future<void> _saveprefs() async {
    _prefs?.setStringList(key, [_currencyFilter.currencyString, _orderFilter.orderStringForService]);
  }

  void saveFilters(CurrencyFilter currencyFilter, OrderFilter orderFilter) {
    _orderFilter = orderFilter;
    _currencyFilter = currencyFilter;
    _saveprefs();
    notifyListeners();
  }


  CurrencyFilter _stringToCurrencyFilter(String string) {
    if (string == CurrencyFilter.eur.currencyString) {
      return CurrencyFilter.eur;
    } else if (string == CurrencyFilter.jpn.currencyString) {
      return CurrencyFilter.jpn;
    } else if (string == CurrencyFilter.usd.currencyString) {
      return CurrencyFilter.usd;
    } else {
      return CurrencyFilter.eur;
    }
  }

  OrderFilter _stringTosetOrderFilter(String string) {
    if (string == OrderFilter.marketCapAsc.orderStringForService) {
      return OrderFilter.marketCapAsc;
    } else if (string == OrderFilter.marketCapDesc.orderStringForService) {
      return OrderFilter.marketCapDesc;
    } else {
      return OrderFilter.marketCapDesc;
    }
  }

}

enum FilterType {
  currency,
  order,
  none,
}

enum CurrencyFilter {
  eur,
  jpn,
  usd,
}

extension CurrencyFilterExtension on CurrencyFilter {
  String get currencyString {
    switch(this) {
      case CurrencyFilter.eur:
      return "eur";
      case CurrencyFilter.jpn:
      return "jpy";
      case CurrencyFilter.usd:
      return "usd";
    } 
  }

  String get currencySymbol {
    switch (this) {
      case CurrencyFilter.eur:
        return "€";
      case CurrencyFilter.jpn:
        return "¥";
      case CurrencyFilter.usd:
        return "\$";
    }
  }
}

enum OrderFilter {
  marketCapAsc,
  marketCapDesc,
}

extension OrderFilterExtension on OrderFilter {
  String get orderStringForService {
    switch(this) {
      case OrderFilter.marketCapAsc:
      return "market_cap_asc";
      case OrderFilter.marketCapDesc:
      return "market_cap_desc";
    } 
  }

  String get orderStringForFilter {
    switch (this) {
      case OrderFilter.marketCapAsc:
        return "Market Cap Ascending";
      case OrderFilter.marketCapDesc:
        return "Market Cap Descending";
    }
  }
}