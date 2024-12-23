import 'package:CoinKeep/src/data/models/coin_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=3000';
  final String _apiKey = '2e0a49a9-a164-4cf4-85c2-663d4c2931ee';

  Future<CoinModel> fetchCoins() async {
    try {
      _dio.options.headers['X-CMC_PRO_API_KEY'] = _apiKey;
      Response response = await _dio.get(_url);
      return CoinModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CoinModel.withError("Data not found / Connection issue");
    }
  }
}
