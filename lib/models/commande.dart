class Commande {
  final int id;
  final int actorId;
  final String actorType;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Commande({
    required this.id,
    required this.actorId,
    required this.actorType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a Commande instance from JSON
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      actorId: json['actorId'],
      actorType: json['actorType'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Convert a Commande instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actorId': actorId,
      'actorType': actorType,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
