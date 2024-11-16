class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Factory constructor for creating a Category instance from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  // Convert a Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
