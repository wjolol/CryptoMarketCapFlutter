import 'package:crypto_market_cap_flutter/Repositories/main_page_repository.dart';
import 'package:crypto_market_cap_flutter/Utility/themes.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  //Register the repository with his implementation
  locator.registerFactory<MainPageRepository>(() => MainPageRepositoryImpl());
  locator.registerFactory<Themes>(() => Themes());
}

