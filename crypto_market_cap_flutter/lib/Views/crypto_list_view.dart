import 'package:crypto_market_cap_flutter/Utility/filter.dart';
import 'package:crypto_market_cap_flutter/Views/crypto_detail_view.dart';
import 'package:crypto_market_cap_flutter/widgets/filter_container.dart';
import 'package:crypto_market_cap_flutter/widgets/loader.dart';
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
  late Filters filtersViewModel;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<MainViewModel>(context, listen: false);
    themeManager = Provider.of<Themes>(context, listen: false);
    filtersViewModel = Provider.of<Filters>(context, listen: false);
    _getDataAndBuildUI();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _getDataAndBuildUI() async {
    await filtersViewModel.loadprefs();
    await viewModel.fetchData(filtersViewModel.currencyFilter.currencyString,
        filtersViewModel.orderFilter.orderStringForService);
  }

  void _reloadWithNewData() async {
    await viewModel.fetchData(filtersViewModel.currencyFilter.currencyString,
        filtersViewModel.orderFilter.orderStringForService);
    _scrollToTop();
  }

  void _scrollToTop() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crypto Market Cap',
              style: Theme.of(context).textTheme.titleMedium),
          actions: [
            ElevatedButton(
                style: themeManager.darkTheme
                    ? themeManager.darkThemeData.elevatedButtonTheme.style
                    : themeManager.brightThemeData.elevatedButtonTheme.style,
                onPressed: () => {themeManager.switchTheme()},
                child: Icon(
                    themeManager.darkTheme ? Icons.sunny : Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color))
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
          child: Column(children: [
            FilterContainer(
              applyFiltersAndReload: _reloadWithNewData,
            ),
            Expanded(child: Consumer<MainViewModel>(
                builder: (context, mainViewModel, child) {
              return mainViewModel.isLoading
                  ? const Loader()
                  : ListView.builder(
                      controller: _controller,
                      itemCount: viewModel.cryptoDataList.length,
                      itemBuilder: (context, index) {
                        final cryptoData = viewModel.cryptoDataList[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => CryptoDetailView(
                                          cryptoId: cryptoData.id,
                                          cryptoImage: cryptoData.image,
                                          cryptoName: cryptoData.name))));
                            },
                            child: CryptoTableRow(
                                cryptoData: cryptoData,
                                position: (index + 1).toString()));
                      });
            })),
          ]),
        ));
  }
}
