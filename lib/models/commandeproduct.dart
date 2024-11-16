class CommandeProduct {
  final int id;
  final int commandeId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommandeProduct({
    required this.id,
    required this.commandeId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a CommandeProduct instance from JSON
  factory CommandeProduct.fromJson(Map<String, dynamic> json) {
    return CommandeProduct(
      id: json['id'],
      commandeId: json['commandeId'],
      productId: json['productId'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert a CommandeProduct instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commandeId': commandeId,
      'productId': productId,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
