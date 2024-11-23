class Product {
  final int id;
  final String name;
  final int pricePerDetail;
  final int priceWholesale;
  final int buyPrice;
  final DateTime buyDate;
  final DateTime expireDate;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? quantity; // Nullable

  Product({
    required this.id,
    required this.name,
    required this.pricePerDetail,
    required this.priceWholesale,
    required this.buyPrice,
    required this.buyDate,
    required this.expireDate,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.quantity, // Nullable
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      //print('Product JSON: $json'); // Log the product JSON
      return Product(
        id: json['id'],
        name: json['name'] ?? '',
        pricePerDetail: json['pricePerDetail'] ?? 0,
        priceWholesale: json['priceWholesale'] ?? 0,
        buyPrice: json['buyPrice'] ?? 0,
        buyDate: DateTime.parse(json['buyDate']),
        expireDate: DateTime.parse(json['expireDate']),
        categoryId: json['categoryId'] ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        quantity: (json['CommandeProduct'] as Map<String, dynamic>?)?['quantity'],
      );
    } catch (e) {
      print('Error parsing Product: $e'); // Log the error
      rethrow; // Re-throw to propagate the issue
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pricePerDetail': pricePerDetail,
      'priceWholesale': priceWholesale,
      'buyPrice': buyPrice,
      'buyDate': buyDate.toIso8601String(),
      'expireDate': expireDate.toIso8601String(),
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (quantity != null) 'CommandeProduct': {'quantity': quantity}, // Add if not null
    };
  }
}
