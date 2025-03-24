import 'package:CoinKeep/src/data/models/coin_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final int _maxRetries = 3;
  final String _url = 'https://coinkeep-server.fly.dev/api/coins';

  Future<CoinModel> fetchCoins() async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        Response response = await _dio.get(_url);
        return CoinModel.fromJson(response.data);
      } catch (e) {
        if (attempt == _maxRetries) {
          return CoinModel.withError("Connection failed");
        }
        await Future.delayed(Duration(seconds: attempt * 2)); // Затримка
      }
    }
    return CoinModel.withError("Unexpected error");
  }
}
