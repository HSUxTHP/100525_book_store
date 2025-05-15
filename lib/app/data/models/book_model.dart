class Book {
  final String id;
  final String name;
  final List<String> imageUrl;
  final double price;
  final String description;
  final String size;
  late final int inStock;
  final int maxBuy;
  final DateTime dateSell;
  final String data;
  final int dataNum;

  Book({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.size,
    required this.inStock,
    required this.maxBuy,
    required this.dateSell,
    required this.data,
    required this.dataNum,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'description': description,
    'size': size,
    'inStock': inStock,
    'maxBuy': maxBuy,
    'dateSell': dateSell.toIso8601String(),
    'data': data,
    'dataNum': dataNum,
  };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      imageUrl: List<String>.from(json['imageUrl']),
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock:
          json['inStock'] is String
              ? int.parse(json['inStock'])
              : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
      data: json['data'] ?? '',
      dataNum: json['dataNum'] ?? 0,
    );
  }
}

class DetailBook extends Book {
  DetailBook({
    required String id,
    required String name,
    required List<String> imageUrl,
    required double price,
    required String description,
    required String size,
    required int inStock,
    required int maxBuy,
    required DateTime dateSell,
    required String data,
    required int dataNum,
  }) : super(
         id: id,
         name: name,
         imageUrl: imageUrl,
         price: price,
         description: description,
         size: size,
         inStock: inStock,
         maxBuy: maxBuy,
         dateSell: dateSell,
          data: data,
          dataNum: dataNum,
       );
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'description': description,
    'size': size,
    'inStock': inStock,
    'maxBuy': maxBuy,
    'dateSell': dateSell.toIso8601String(),
    'data': data,
    'dataNum': dataNum,
  };
  factory DetailBook.fromJson(Map<String, dynamic> json) {
    return DetailBook(
      id: json['id'],
      name: json['name'],
      imageUrl: List<String>.from(json['imageUrl']),
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock:
          json['inStock'] is String
              ? int.parse(json['inStock'])
              : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
      data: json['data'] ?? '',
      dataNum: json['dataNum'] ?? 0,
    );
  }
}

class BookInCart extends Book {
  int quantity;
  bool isEBook;

  BookInCart({
    required String id,
    required String name,
    required List<String> imageUrl,
    required double price,
    required String description,
    required String size,
    required int inStock,
    required int maxBuy,
    required DateTime dateSell,
    required String data,
    required int dataNum,
    this.isEBook = false,
    this.quantity = 1,
  }) : super(
         id: id,
         name: name,
         imageUrl: imageUrl,
         price: price,
         description: description,
         size: size,
         inStock: inStock,
         maxBuy: maxBuy,
         dateSell: dateSell,
          data: data,
          dataNum: dataNum,
       );
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'description': description,
    'quantity': quantity,
    'isEBook': isEBook,
    'size': size,
    'inStock': inStock,
    'maxBuy': maxBuy,
    'dateSell': dateSell.toIso8601String(),
    'data': data,
    'dataNum': dataNum,
  };
  factory BookInCart.fromJson(Map<String, dynamic> json) {
    return BookInCart(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock:
          json['inStock'] is String
              ? int.parse(json['inStock'])
              : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
      quantity: json['quantity'] ?? 1,
      isEBook: json['isEBook'] ?? false,
      data: json['data'] ?? '',
      dataNum: json['dataNum'] ?? 0,
    );
  }
}

class BookInUser extends Book {
  bool isEBook;

  BookInUser({
    required String id,
    required String name,
    required List<String> imageUrl,
    required double price,
    required String description,
    required String size,
    required int inStock,
    required int maxBuy,
    required DateTime dateSell,
    required String data,
    required int dataNum,
    this.isEBook = false,
  }) : super(
         id: id,
         name: name,
         imageUrl: imageUrl,
         price: price,
         description: description,
         size: size,
         inStock: inStock,
         maxBuy: maxBuy,
         dateSell: dateSell,
          dataNum: dataNum,
          data: data,
       );
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'description': description,
    'isEBook': isEBook,
    'size': size,
    'inStock': inStock,
    'maxBuy': maxBuy,
    'dateSell': dateSell.toIso8601String(),
    'data': data,
    'dataNum': dataNum,
  };
  factory BookInUser.fromJson(Map<String, dynamic> json) {
    return BookInUser(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      description: json['description'],
      size: json['size'],
      inStock:
      json['inStock'] is String
          ? int.parse(json['inStock'])
          : json['inStock'],
      maxBuy: json['maxBuy'],
      dateSell: DateTime.parse(json['dateSell']),
      isEBook: json['isEBook'] ?? false,
      data: json['data'] ?? '',
      dataNum: json['dataNum'] ?? 0,
    );
  }
}
