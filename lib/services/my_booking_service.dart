import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/model/my_booking_model.dart';
import 'package:rentyne/resources/url_paths.dart';

Future<List<MyBookingModel>> fetchBookings(int userId) async {
  final url = Uri.parse("${AppUrl.myBooking}?user_id=$userId");

  try {
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    debugPrint('inside try');

    if (response.statusCode == 200) {
      debugPrint('inside 200');
      if (responseData is List) {
        return responseData.map((json) => MyBookingModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else if (response.statusCode == 400 && responseData is Map && responseData.containsKey('error')) {
      debugPrint('inside 400');
      final errorModel = ErrorResponseModel.fromJson(Map<String, dynamic>.from(responseData));
      throw Exception(errorModel.error);
    } else {
      throw Exception('Failed to load bookings. Status code: ${response.statusCode}');
    }
  } on FormatException catch (error) {
    debugPrint('FormatException: $error');
    rethrow;
  } on SocketException catch (_) {
    debugPrint('SocketException: No Internet');
    rethrow;
  } on TimeoutException catch (_) {
    debugPrint('TimeoutException: Request timed out');
    rethrow;
  } catch (e) {
    debugPrint('Unexpected error: $e');
    rethrow;
  }
}
