class CoinModel {
  List<Data>? data;
  String? error;

  CoinModel({this.data}); // Constructor

  CoinModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  } //Конструктор, що створює об'єкт з JSON.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  } //Метод для перетворення об'єкта в JSON.

  CoinModel.withError(String errorMessage) {
    error = errorMessage;
  } // Конструктор для створення об'єкта з помилкою.
}

class Data {
  int? id;
  String? name;
  String? symbol;
  Quote? quote;

  Data({this.id, this.name, this.symbol, this.quote}); // Constructor

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  } //Конструктор, що створює об'єкт з JSON.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    if (this.quote != null) {
      data['quote'] = this.quote!.toJson();
    }
    return data;
  } //Метод для перетворення об'єкта в JSON.
}

class Quote {
  USD? uSD;

  Quote({this.uSD}); // Constructor

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  } //Конструктор, що створює об'єкт з JSON.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD!.toJson();
    }
    return data;
  } //Метод для перетворення об'єкта в JSON.
}

class USD {
  double? price;

  USD({this.price}); // Constructor

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  } //Конструктор, що створює об'єкт з JSON.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  } //Метод для перетворення об'єкта в JSON.
}
