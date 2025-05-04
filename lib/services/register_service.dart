import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentyne/model/register_model.dart';
import 'package:rentyne/resources/url_paths.dart';

Future<dynamic> registerUser(String username, String email, String phone, String password) async {
  final Map<String, dynamic> apiBodyData = {
    'user': username,
    'email': email,
    'phone': phone,
    'passwd': password,
  };

  final url = Uri.parse(AppUrl.register);

  try {
    final response = await http.post(
      url,
      body: json.encode(apiBodyData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = registerModelFromJson(response.body);
      debugPrint("Success : $responseData");
      return responseData;
    } else {

      final errorResponse = RegisterErrorModel.fromJson(json.decode(response.body));
      debugPrint('Error: $errorResponse');
      return errorResponse;
      // final Map<String, dynamic> errorResponse = json.decode(response.body);
      // final Map<String, List<String>> readableErrors = {};

      // errorResponse.forEach((key, value) {
      //   if (value is List) {
      //     readableErrors[key] = List<String>.from(value);
      //   }
      // });

      // debugPrint('Validation Errors: $readableErrors');
      // return {'errors': readableErrors};
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
    rethrow;
  } catch (e) {
    debugPrint('Unknown Error: $e');
    rethrow;
  }
}
