import 'package:crypto_market_cap_flutter/Views/crypto_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/widgets/table_row.dart';
import 'package:crypto_market_cap_flutter/ViewModels/main_view_model.dart';
import 'package:provider/provider.dart';
import '../Utility/themes.dart';

class CryptoListView extends StatefulWidget {
  const CryptoListView({super.key});
  @override
  State<CryptoListView> createState() => _CryptoListView();
}

class _CryptoListView extends State<CryptoListView> {

  late MainViewModel viewModel;
  late Themes themeManager;
 
  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<MainViewModel>(context, listen: false);
    themeManager = Provider.of<Themes>(context, listen: false);
    getDataAndBuildUI();
  }

  void getDataAndBuildUI() async {
    await viewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Market Cap', style: Theme.of(context).textTheme.titleMedium),
        actions: [ElevatedButton(style: 
          themeManager.darkTheme ? themeManager.darkThemeData.elevatedButtonTheme.style : themeManager.brightThemeData.elevatedButtonTheme.style,
          onPressed:() => {themeManager.switchTheme()}, 
          child: Icon(themeManager.darkTheme ? Icons.sunny : Icons.dark_mode, color: Theme.of(context).iconTheme.color))
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:
      ChangeNotifierProvider(
        create: (context) => viewModel,
        child: 
        SafeArea(child: 
          Column(children: [
            Expanded(child: 
              Consumer<MainViewModel>(builder: (context, mainViewModel, chid) {
                return 
                ListView.builder(itemCount: viewModel.cryptoDataList.length,
                  itemBuilder: (context, index) {
                    final cryptoData = viewModel.cryptoDataList[index];
                    return GestureDetector(onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => CryptoDetailView(cryptoId: cryptoData.id, cryptoImage: cryptoData.image, cryptoName: cryptoData.name))));
                    },
                    child: CryptoTableRow(cryptoData: cryptoData, position: (index+1).toString()));
                });
              })
            ),
          ]),
        )
      )
    );
  }
}
