class CarModel {
  final int id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final bool isAvailable;
  final DateTime createdAt;
  final double rating;
  final String image;
  final String videoUrl;

  CarModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.createdAt,
    required this.rating,
    required this.image,
    required this.videoUrl,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      price: double.parse(json['price']),
      isAvailable: json['is_available'],
      createdAt: DateTime.parse(json['created_at']),
      rating: double.parse(json['rating']),
      image: json['image'],
      videoUrl: json['video_url'],
    );
  }
}
