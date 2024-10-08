import 'package:CoinKeep/src/data/models/coin_model.dart';
import 'package:CoinKeep/src/data/network/data_providers/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<CoinModel> fetchCoins() {
    return _apiProvider.fetchCoins();
  }
}

class NetworkError extends Error {}
