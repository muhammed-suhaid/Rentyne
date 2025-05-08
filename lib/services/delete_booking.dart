import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/resources/url_paths.dart';

Future<dynamic> deleteBooking(int bookingId) async {
  final url = Uri.parse("${AppUrl.deleteBooking}$bookingId/");

  try {
    final response = await http.delete(url);

    debugPrint("Delete Status Code: ${response.statusCode}");
    debugPrint("Delete Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 204) {
      return {'success': true};
    } else {
      final Map<String, dynamic> error = json.decode(response.body);
      return {'error': error['detail'] ?? 'Unknown error occurred'};
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
