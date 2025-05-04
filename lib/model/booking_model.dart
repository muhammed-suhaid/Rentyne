import 'dart:convert';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) =>
    json.encode(data.toJson());

class BookingModel {
  final String? message;
  final Booking? booking;

  BookingModel({this.message, this.booking});

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      BookingModel(
        message: json["message"],
        booking:
            json["booking"] != null ? Booking.fromJson(json["booking"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "booking": booking?.toJson(),
      };
}

class Booking {
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

  Booking({
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

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        car: json["car"],
        user: json["user"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        bookingDate: json["booking_date"],
        isConfirmed: json["is_confirmed"],
        isCancelled: json["is_cancelled"],
        carDetails: CarDetails.fromJson(json["car_details"]),
        userDetails: UserDetails.fromJson(json["user_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car": car,
        "user": user,
        "start_date": startDate,
        "end_date": endDate,
        "booking_date": bookingDate,
        "is_confirmed": isConfirmed,
        "is_cancelled": isCancelled,
        "car_details": carDetails.toJson(),
        "user_details": userDetails.toJson(),
      };
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

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        description: json["description"],
        price: json["price"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"],
        rating: json["rating"],
        image: json["image"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "description": description,
        "price": price,
        "is_available": isAvailable,
        "created_at": createdAt,
        "rating": rating,
        "image": image,
        "video_url": videoUrl,
      };
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

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        user: json["user"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "email": email,
        "phone": phone,
      };
}
