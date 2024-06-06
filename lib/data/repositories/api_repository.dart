import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:CoinKeep/data/dataproviders/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<CoinModel> fetchCoins() {
    return _apiProvider.fetchCoins();
  }

// test
  Future<CoinModel> searchCoins(query) {
    return _apiProvider.searchCoins(query);
  }
}

class NetworkError extends Error {}
