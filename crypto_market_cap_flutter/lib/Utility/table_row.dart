import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/Models/crypto_data_model.dart';

class CryptoTableRow extends StatefulWidget {
  const CryptoTableRow({super.key, required this.cryptoData, required this.cryptoIndex});

  final CryptoDataModel cryptoData;
  final String cryptoIndex;

  @override
  State<CryptoTableRow> createState() => _CryptoTableRow();
}

class _CryptoTableRow extends State<CryptoTableRow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black)
              ), 
    margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.all(10.0), 
    child:
      Row(children: 
      [
        Text(widget.cryptoIndex),
        const SizedBox(width: 5),
        Image.network(widget.cryptoData.image, width: 20.00, height: 20.00,),
        const SizedBox(width: 10),
        Text(widget.cryptoData.name),
        const SizedBox(width: 30),
        Text(widget.cryptoData.currentPriceFormatted()),
        const Spacer(),
        Text(widget.cryptoData.priceChange24Formatted(), style: TextStyle(color: widget.cryptoData.priceChange24hColor())),
      ],
    )
    );

  }
}