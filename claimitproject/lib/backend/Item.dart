class Item {
  final String name;
  final String category;
  final String color;
  final String location;
  final String description;
  final String? imagePath;
  final String itemType;

  Item({
    required this.name,
    required this.category,
    required this.color,
    required this.location,
    required this.description,
    this.imagePath,
    required this.itemType,
  });

  // Convert JSON to Dart object
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      category: json['category'],
      color: json['color'],
      location: json['location'],
      description: json['description'],
      imagePath: json['image_path'],
      itemType: json['item_type'],
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'color': color,
      'location': location,
      'description': description,
      'image_path': imagePath,
      'item_type': itemType,
    };
  }
}
