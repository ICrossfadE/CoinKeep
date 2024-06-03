import 'package:CoinKeep/data/coin_model.dart';
import 'package:CoinKeep/resource/api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<CoinModel> fetchCoins() {
    return _apiProvider.fetchCoins();
  }
}

class NetworkError extends Error {}
