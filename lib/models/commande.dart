import 'package:grocery/models/product.dart';

class Commande {
  final int id;
  final String actorName; // Nullable
  final int? actorCin;     // Nullable
  final String type;      // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Product> products;

  Commande({
    required this.id,
    required this.actorName,
    this.actorCin,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    try {
      //print('Parsing Commande JSON: $json');

      return Commande(
        id: json['id'],
        actorName: json['actorName'], // Nullable
        actorCin: json['actorCin'],   // Nullable
        type: json['type'],           // Nullable
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        products: (json['Products'] as List)
            .map((item) {
          //print('Parsing product: $item');
          return Product.fromJson(item);
        })
            .toList(),
      );
    } catch (e) {
      print('Error parsing Commande: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actorName': actorName,
      'actorCin': actorCin,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Products': products.map((product) => product.toJson()).toList(),
    };
  }
}
