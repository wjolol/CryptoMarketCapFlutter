import 'package:crypto_market_cap_flutter/Repositories/main_page_repository.dart';
import 'package:crypto_market_cap_flutter/ViewModels/main_view_model.dart';
import 'package:crypto_market_cap_flutter/Views/crypto_list_view.dart';
import 'package:flutter/material.dart';
import 'package:crypto_market_cap_flutter/DependencyInjection/locator.dart';
import 'package:provider/provider.dart';
import 'package:crypto_market_cap_flutter/Utility/themes.dart';

Future<void> main() async {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel(mainPageRepo: locator<MainPageRepository>())),
        ChangeNotifierProvider(create: (_) => Themes()),
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
    return ChangeNotifierProvider(create: (context) => Themes(), child:
      Consumer<Themes>(builder: (context, state, child) {
        return MaterialApp(
            title: 'Crypto Market Cap',
            theme: state.darkTheme ? state.darkThemeData : state.brightThemeData,
            home: const CryptoListView(),
        );
      }) 
    );
  }
}

