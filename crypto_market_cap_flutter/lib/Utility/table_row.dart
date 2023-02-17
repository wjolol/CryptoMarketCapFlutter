import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/Models/crypto_data_model.dart';

class CryptoTableRow extends StatelessWidget {
  final CryptoDataModel cryptoData;
  final String position;

  const CryptoTableRow({super.key, required this.cryptoData, required this.position});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Theme.of(context).cardColor)
              ), 
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0), 
      child:
        Row(children: [
          Text(position, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 5),
          Image.network(cryptoData.image, width: 20.00, height: 20.00,),
          const SizedBox(width: 10),
          Text(cryptoData.name, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 30),
          Text(cryptoData.currentPriceFormatted(), style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(cryptoData.priceChange24Formatted(), style: TextStyle(color: cryptoData.priceChange24hColor())),
        ],)
    );
  }
}