class Product {
  final int id;
  final String name;
  final double pricePerDetail;
  final double priceWholesale;
  final int categoryId;

  Product({
    required this.id,
    required this.name,
    required this.pricePerDetail,
    required this.priceWholesale,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      pricePerDetail: json['pricePerDetail'].toDouble(),
      priceWholesale: json['priceWholesale'].toDouble(),
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pricePerDetail': pricePerDetail,
      'priceWholesale': priceWholesale,
      'categoryId': categoryId,
    };
  }
}
