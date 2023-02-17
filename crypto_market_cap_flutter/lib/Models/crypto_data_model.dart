import 'dart:convert';
import 'package:flutter/material.dart';

class CryptoDataModel {
  final String image;
  final String id;
  final String symbol;
  final String name;
  final dynamic currentPrice;
  final int marketCap;
  final int marketCapRank;
  final dynamic priceChange24h;

  CryptoDataModel(this.name, this.image, this.id, this.symbol, this.currentPrice, this.marketCap, this.marketCapRank, this.priceChange24h);

  List<CryptoDataModel> modelCryptoDataFromJson(String str) => 
  List<CryptoDataModel>.from(json.decode(str).map((x) => CryptoDataModel.fromJson(x)));

  CryptoDataModel.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        image = json['image'],
        id = json['id'],
        symbol = json['symbol'],
        currentPrice = json['current_price'],
        marketCap = json['market_cap'],
        marketCapRank = json['market_cap_rank'],
        priceChange24h = json['price_change_24h']
  ;

  String currentPriceFormatted() {
    if (currentPrice is int || currentPrice is double) {
      String formattedPrice = "-";
      if (currentPrice < 1) {
        formattedPrice = currentPrice.toStringAsFixed(5);
      } else {
        formattedPrice = currentPrice.toStringAsFixed(2);
      } 
      return "$formattedPrice€";
    } 
    return "-";
  }

  String priceChange24Formatted() {
    if (priceChange24h is int || priceChange24h is double) {
      return priceChange24h.toStringAsFixed(4);
    } 
    return "Error";
  }

  Color priceChange24hColor() {
    if (priceChange24h is int || priceChange24h is double) {
      if (priceChange24h > 0) {
        return Colors.green;
      }
      else {
        return Colors.red;
      }
    }
    return Colors.black;

  }
}