import 'package:crypto_market_cap_flutter/ViewModels/crypto_detail_view_model.dart';
import 'package:crypto_market_cap_flutter/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoDetailView extends StatefulWidget {
  const CryptoDetailView({super.key, required this.cryptoId, required this.cryptoImage, required this.cryptoName});

  final String cryptoId;
  final String cryptoImage;
  final String cryptoName;

  @override
  State<CryptoDetailView> createState() => _CryptoDetailView();
}

class _CryptoDetailView extends State<CryptoDetailView> {

  late CryptoDetailViewModel viewModel;
  var isLoading = false;
 
  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<CryptoDetailViewModel>(context, listen: false);
    getDataAndBuildUI();
  }

  void getDataAndBuildUI() async {
    await viewModel.fetchData(widget.cryptoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Market Cap', style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).iconTheme,
        leading: 
        IconButton(
          onPressed: () {
            viewModel.eraseDescription();
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: 
      Center(child: 
        SafeArea(child: 
          ListView(padding: const EdgeInsets.all(10),
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Hero(
                  tag: "${widget.cryptoId}logo",
                  child: 
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 90.0,
                    child: Image.network(widget.cryptoImage, width: 90.00, height: 90.00,),
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(widget.cryptoName, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10.0,),
                Consumer<CryptoDetailViewModel>(builder: (context, viewModel, child) {
                  return viewModel.isLoading ? const SizedBox(height: 200, child: Loader(),) :
                   Text(viewModel.getDescription(), style: Theme.of(context).textTheme.bodyMedium);
                })
              ],),
          ],)
        )
      )
    );
  }
}
