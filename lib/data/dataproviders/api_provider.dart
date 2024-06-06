import 'package:CoinKeep/data/models/coin_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';
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

// test
  Future<CoinModel> searchCoins(query) async {
    try {
      _dio.options.headers['X-CMC_PRO_API_KEY'] = _apiKey;
      String url = _url;
      if (query != null) {
        // Якщо запит не null, додаємо параметр для пошуку монети
        url += '?limit=$query';
      }
      Response response = await _dio.get(url);
      return CoinModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CoinModel.withError("Data not found / Connection issue");
    }
  }
}
