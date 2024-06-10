class CoinModel {
  List<Data>? data;
  String? error;

  CoinModel({this.data = const []}); // Constructor

  // Метод копіювання
  CoinModel copyWith({List<Data>? data, String? error}) {
    return CoinModel(
      data: data ?? this.data,
    );
  }

  // Метод для перетворення об'єкта в JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'data': this.data?.map((v) => v.toJson()).toList(),
    };
    return data;
  }

  // Конструктор для створення об'єкта з JSON.
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : null,
    );
  }

  // Конструктор для створення об'єкта з помилкою.
  CoinModel.withError(String errorMessage, {this.data}) : error = errorMessage;
}

class Data {
  int? id;
  String? name;
  String? symbol;
  Quote? quote;

  Data({this.id, this.name, this.symbol, this.quote}); // Constructor

  Data copyWith({int? id, String? name, String? symbol, Quote? quote}) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      quote: quote ?? this.quote?.copyWith(),
    );
  }

  //Конструктор, що створює об'єкт з JSON.
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  //Метод для перетворення об'єкта в JSON.
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

  Quote({this.uSD}); // Constructor

  Quote copyWith({USD? uSD}) {
    return Quote(
      uSD: uSD ?? this.uSD?.copyWith(),
    );
  }

  //Конструктор, що створює об'єкт з JSON.
  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  //Метод для перетворення об'єкта в JSON.
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

  USD({this.price}); // Constructor

  USD copyWith({double? price}) {
    return USD(
      price: price ?? this.price,
    );
  }

  //Конструктор, що створює об'єкт з JSON.
  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  //Метод для перетворення об'єкта в JSON.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  }
}
