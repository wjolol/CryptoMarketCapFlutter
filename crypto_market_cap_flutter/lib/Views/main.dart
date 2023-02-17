import 'package:crypto_market_cap_flutter/Repositories/main_page_repository.dart';
import 'package:crypto_market_cap_flutter/ViewModels/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/Utility/table_row.dart';
import 'package:crypto_market_cap_flutter/DependencyInjection/locator.dart';
import 'package:provider/provider.dart';
import 'package:crypto_market_cap_flutter/Utility/themes.dart';

Future<void> main() async {
   
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainViewModel(mainPageRepo: locator<MainPageRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Market Cap',
      theme: Themes.brightTheme,
      home: const MyHomePage(title: 'Crypto Market Cap'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late MainViewModel viewModel;
  final List<CryptoTableRow> listViewItems = [];

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<MainViewModel>(context, listen: false);
    getDataAndBuildUI();
  }

  void getDataAndBuildUI() async {
    await viewModel.fetchData();
      setState(() {
        viewModel.cryptoDataList;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(child: 
        Column(children: [
          Expanded(child: 
            ListView.builder(itemCount: viewModel.cryptoDataList.length,
              itemBuilder: (context, index) {
              return CryptoTableRow(cryptoData: viewModel.cryptoDataList[index], cryptoIndex: (index+1).toString());
            })
          ),
        ]),
      )
    );
  }
}
