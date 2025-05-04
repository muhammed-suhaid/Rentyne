import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/model/car_model.dart';
import 'package:rentyne/resources/url_paths.dart';

Future<List<CarModel>> fetchCars() async {
  final url = Uri.parse(AppUrl.carData);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Log the response for debugging
      debugPrint(responseData.toString());

      // Convert JSON to List<CarModel>
      return responseData.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load car data. Status code: ${response.statusCode}');
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
