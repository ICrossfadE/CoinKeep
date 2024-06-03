class CoinModel {
  List<Data>? data;
  String? error;

  CoinModel({this.data});

  CoinModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CoinModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

class Data {
  int? id;
  String? name;
  String? symbol;
  Quote? quote;

  Data({this.id, this.name, this.symbol, this.quote});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    if (this.quote != null) {
      data['quote'] = this.quote!.toJson();
    }
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD!.toJson();
    }
    return data;
  }
}

class USD {
  double? price;

  USD({this.price});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  }
}


// import 'dart:convert';

// CoinModel coinModelFromJson(String str) => CoinModel.fromJson(json.decode(str));

// String coinModelToJson(CoinModel data) => json.encode(data.toJson());

// class CoinModel {
//   int id;
//   String name;
//   String symbol;
//   Quote quote;

//   CoinModel({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.quote,
//   });

//   CoinModel copyWith({
//     int? id,
//     String? name,
//     String? symbol,
//     Quote? quote,
//   }) =>
//       CoinModel(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         symbol: symbol ?? this.symbol,
//         quote: quote ?? this.quote,
//       );

//   factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
//         id: json["id"],
//         name: json["name"],
//         symbol: json["symbol"],
//         quote: Quote.fromJson(json["quote"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "symbol": symbol,
//         "quote": quote.toJson(),
//       };
// }

// class Quote {
//   Usd usd;

//   Quote({
//     required this.usd,
//   });

//   Quote copyWith({
//     Usd? usd,
//   }) =>
//       Quote(
//         usd: usd ?? this.usd,
//       );

//   factory Quote.fromJson(Map<String, dynamic> json) => Quote(
//         usd: Usd.fromJson(json["USD"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "USD": usd.toJson(),
//       };
// }

// class Usd {
//   double price;

//   Usd({
//     required this.price,
//   });

//   Usd copyWith({
//     double? price,
//   }) =>
//       Usd(
//         price: price ?? this.price,
//       );

//   factory Usd.fromJson(Map<String, dynamic> json) => Usd(
//         price: json["price"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "price": price,
//       };
// }
