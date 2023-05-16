class CryptoDetailModel {
  DescriptionModel description;

  CryptoDetailModel(this.description);

  factory CryptoDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    return CryptoDetailModel(
        DescriptionModel.fromJson(parsedJson["description"]));
  }
}

class DescriptionModel {
  String text;
  DescriptionModel(this.text);

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(json['en'] as String);
  }
}
