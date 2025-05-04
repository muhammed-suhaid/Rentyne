class MyBookingModel {
  final int id;
  final int car;
  final int user;
  final String startDate;
  final String endDate;
  final String bookingDate;
  final bool isConfirmed;
  final bool isCancelled;
  final CarDetails carDetails;
  final UserDetails userDetails;

  MyBookingModel({
    required this.id,
    required this.car,
    required this.user,
    required this.startDate,
    required this.endDate,
    required this.bookingDate,
    required this.isConfirmed,
    required this.isCancelled,
    required this.carDetails,
    required this.userDetails,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      id: json['id'],
      car: json['car'],
      user: json['user'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      bookingDate: json['booking_date'],
      isConfirmed: json['is_confirmed'],
      isCancelled: json['is_cancelled'],
      carDetails: CarDetails.fromJson(json['car_details']),
      userDetails: UserDetails.fromJson(json['user_details']),
    );
  }
}

class CarDetails {
  final int id;
  final String name;
  final String brand;
  final String description;
  final String price;
  final bool isAvailable;
  final String createdAt;
  final String rating;
  final String image;
  final String videoUrl;

  CarDetails({
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

  factory CarDetails.fromJson(Map<String, dynamic> json) {
    return CarDetails(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      description: json['description'],
      price: json['price'],
      isAvailable: json['is_available'],
      createdAt: json['created_at'],
      rating: json['rating'],
      image: json['image'],
      videoUrl: json['video_url'],
    );
  }
}

class UserDetails {
  final String user;
  final String email;
  final String phone;

  UserDetails({
    required this.user,
    required this.email,
    required this.phone,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      user: json['user'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class ErrorResponseModel {
  final String error;

  ErrorResponseModel({required this.error});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      error: json['error'] ?? 'Unknown error',
    );
  }
}