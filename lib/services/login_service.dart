import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/model/login_model.dart';
import 'package:rentyne/resources/url_paths.dart';

Future<dynamic> loginUser(String username, String password) async {
  final Map<String, dynamic> apiBodyData = {
    'user': username,
    'pass': password,
  };

  final url = Uri.parse(AppUrl.login);

  try {
    final response = await http.post(
      url,
      body: json.encode(apiBodyData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body).toString());
      final responseData = loginModelFromJson(response.body);
      return responseData;
    } else {
      final errorResponse = LoginErrorModel.fromJson(json.decode(response.body));
      debugPrint('Error: ${errorResponse.error}');
      return errorResponse;
    }
  } on FormatException catch (error) {
    debugPrint('Format Exception: ${error.toString()}');
    rethrow;
  } on SocketException catch (_) {
    debugPrint('No Internet Connection');
    rethrow;
  } on TimeoutException catch (_) {
    debugPrint('Request Timed Out');
    rethrow;
  } on DeferredLoadException catch (_) {
    debugPrint('Deferred Load Exception');
  } catch (e) {
    debugPrint('Unknown Error: $e');
    rethrow;
  } finally {
    // Optional: Perform cleanup or logging here
  }
}
