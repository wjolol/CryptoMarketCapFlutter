
class CryptoDetailModel {
  // final String image;
  // final String id;
  // final String symbol;
  // final String name;
  DescriptionModel description;
  // final dynamic currentPrice;
  // final int marketCap;
  // final int marketCapRank;
  // final dynamic priceChange24h;

  CryptoDetailModel(this.description);

  factory CryptoDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    return CryptoDetailModel(
      DescriptionModel.fromJson(parsedJson["description"])
    );
  }

}

class DescriptionModel {
  String text;
  DescriptionModel(this.text);
  
  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(json['en'] as String);
  } 

}