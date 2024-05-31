import 'dart:collection';

String CMC_PRO_API_KEY = '2e0a49a9-a164-4cf4-85c2-663d4c2931ee';

class Quote {
  final CurrencyInfo usd;

  // constructor
  Quote({required this.usd});

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('USD')) {
      return Quote(usd: CurrencyInfo.fromJson(json['USD']));
    } else {
      throw Exception("Key 'USD' not found in Quote JSON");
    }
  }
} // Quote

class CurrencyInfo {
  final double price;

  // constructor
  CurrencyInfo({required this.price});

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('price')) {
      return CurrencyInfo(price: json['price']);
    } else {
      throw Exception("Key 'price' not found in CurrencyInfo JSON");
    }
  }
} // CurrencyInfo

class Coin {
  final int id;
  final String name;
  final String symbol;
  final Quote quote;

  // constructor
  Coin(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.quote});

  Coin copyWith({
    int? id,
    String? name,
    String? symbol,
    Quote? quote,
  }) {
    return Coin(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      quote: quote ?? this.quote,
    );
  }

  factory Coin.fromJson(Map<String, dynamic> json) {
    final bool condition = json.containsKey('id') &&
        json.containsKey('name') &&
        json.containsKey('symbol') &&
        json.containsKey('quote');

    if (condition) {
      return Coin(
        id: json['id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        symbol: json['symbol'] as String? ?? '',
        quote: Quote.fromJson(json['quote']),
      );
    } else {
      throw Exception("One or more keys not found in Coin JSON");
    }
  }
}// Coin
