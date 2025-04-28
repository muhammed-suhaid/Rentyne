class Car {
  const Car({
    required this.id,
    required this.brand,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.isAvailable,
    required this.createdAt,
    required this.cost,
    required this.rating,
  });

  final String id;
  final String brand;
  final String name;
  final String imageUrl;
  final String description;
  final String isAvailable;
  final String createdAt;
  final String cost;
  final String rating;
}
