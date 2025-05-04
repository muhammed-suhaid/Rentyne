import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/model/booking_model.dart';
import 'package:rentyne/resources/url_paths.dart';

Future<dynamic> createBooking({
  required int carId,
  required int userId,
  required String startDate,
  required String endDate,
}) async {
  final url = Uri.parse(AppUrl.booking);

  final Map<String, dynamic> bookingData = {
    "car_id": carId,
    "user_id": userId,
    "start_date": startDate,
    "end_date": endDate,
  };

  try {
    final response = await http.post(
      url,
      body: json.encode(bookingData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      //return BookingModel.fromJson(json.decode(response.body));
      debugPrint(json.decode(response.body).toString());
      final responseData = bookingModelFromJson(response.body);
      return responseData;
    } else {
      final Map<String, dynamic> error = json.decode(response.body);
      return error;
    }
  } on SocketException {
    return {'error': 'No Internet connection'};
  } on TimeoutException {
    return {'error': 'Request timeout'};
  } on FormatException {
    return {'error': 'Bad response format'};
  } catch (e) {
    return {'error': 'Unexpected error: $e'};
  }
}
