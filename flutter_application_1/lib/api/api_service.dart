// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pretty_logger/pretty_logger.dart';

// 🌎 Project imports:

// ignore: constant_identifier_names
enum ApiMethod { GET, POST, PUT, PATCH, DELETE }

class TokenResponse {
  final String token;

  TokenResponse(this.token);

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(json['access']);
  }
}

class ApiService {
  /// The max time to wait for a response from the api
  static Duration timeout = const Duration(seconds: 45);

  /// If is true, the api calls will be made to the testing api
  static const bool devMode = false;

  static const String honorUrl = devMode ? '' : '';

  /// The url to be used for the api calls ()
  /// The url to be used for LOCAL the api calls ()
  static const String honorApi = devMode ? '' : "http://127.0.0.1:8000/api";

  /// The url to be used for the testing api calls (https://staging.wizz.life/api)
  static const String honorStagingApi = devMode ? '' : '';

  /// The max number of items to be shown on a endpoint with pagination
  static const int pageMaxCount = 10;

  /// Initialize the ApiService
  static Future init() async {
    //TODO: Initialize the preferences
  }

  /// Get Kairos token from the preferences (set on screens/login/verify_email_screen.dart)
  static String getToken() {
    //TODO: get preferences token
    return '';
  }

  static Future getUserInfo({required int userId}) async {
    try {
      final response = await http.get(
        Uri.parse(''),
      );
      //TODO: Get user info from the api

      if (response.statusCode == 200) {
        // TODO: Set the user info on the preferences

        // If the user full name is empty, get it from the username

        // TODO: Rebuild the UI to update the user info
        PLog.success('✅ User info updated successfully');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        handleError(response: response, message: 'Failed to get user info');
      }
    } catch (e, stackTrace) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //TODO: Show error with toast
      });
    }
  }

  static Map<String, String> getBasicHeaders({
    bool? withToken = true,
    Map<String, String>? additionalHeaders,
  }) {
    return <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      if (withToken == true)
        HttpHeaders.authorizationHeader: 'Bearer ${getToken()}',
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  // For handle errors on every api call
  static void handleError(
      {required dynamic response, required String message}) {
    String responseMessage = 'Unknown error';

    if (response != null) {
      try {
        int? statusCode;
        Map<String, dynamic>? responseBody;

        if (response is StreamedResponse) {
          final streamedResponse = response;
          statusCode = streamedResponse.statusCode;

          // Check if the status code is 500 or the response is HTML
          if (statusCode == 500 ||
              streamedResponse.headers['content-type']?.contains('text/html') ==
                  true) {
            responseMessage = 'Server Error: Status Code $statusCode';
          } else {
            streamedResponse.stream.transform(utf8.decoder).listen((body) {
              final decodedBody = jsonDecode(body);
              responseBody = decodedBody;
            });
          }
        } else if (response is Response) {
          statusCode = response.statusCode;

          // Check if the status code is 500 or the response is HTML
          if (statusCode == 500 ||
              response.headers['content-type']?.contains('text/html') == true) {
            responseMessage = 'Server Error: Status Code $statusCode';
          } else {
            responseBody = jsonDecode(utf8.decode(response.bodyBytes));
          }
        }

        if (responseBody != null) {
          responseMessage = 'Status Code: $statusCode\nBody: $responseBody';
          throw Exception(responseMessage);
        }
      } catch (e) {
        responseMessage = 'Error processing response: $e';
        throw Exception(responseMessage);
      }
    }

    PLog.error('-----------------------------------------------------------');
    PLog.error('[Error] $message');
    PLog.error('[Cause] $responseMessage');
    PLog.error('-----------------------------------------------------------');
    if (responseMessage.startsWith('Server Error')) {
      throw Exception('Server Error: $message');
    } else {
      throw Exception(responseMessage);
    }
  }

  // --------------------------------------------------- //
  // -------------------- API CALLS -------------------- //
  // --------------------------------------------------- //

  Future loginButter(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('$honorApi/v1/api-token-auth/'),
      headers: getBasicHeaders(withToken: false),
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      handleError(response: response, message: 'Failed to verify email');
    }
  }

  Future sendPdf() async {
    final response = await http.post(
      Uri.parse('$honorApi/upload-jpg/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "jpg-file":
            "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dmV0aWNhLUJvbGQvVHlwZS9Gb250L0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxPj4KZW5kb2JqCjQgMCBvYmo8PC9UeXBlL1BhZ2VzL0NvdW50IDEvS2lkc1s1IDAgUl0+PgplbmRvYmoKNiAwIG9iajw8L1R5cGUvQ2F0YWxvZy9QYWdlcyA0IDAgUj4+CmVuZG9iago3IDAgb2JqPDwvUHJvZHVjZXIoaVRleHQgMS40LjEgXChieSBsb3dhZ2llLmNvbVwpKS9Nb2REYXRlKEQ6MjAyMjEwMTIyMDExMDEtMDMnMDAnKS9BdXRob3IoVFJFQk9MLUlUKS9DcmVhdGlvbkRhdGUoRDoyMDIyMTAxMjIwMTEwMS0wMycwMCcpPj4KZW5kb2JqCnhyZWYKMCA4CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMTY5MSAwMDAwMCBuIAowMDAwMDAxNzc4IDAwMDAwIG4gCjAwMDAwMDAwMTUgMDAwMDAgbiAKMDAwMDAwMTg3MCAwMDAwMCBuIAowMDAwMDAxNTE2IDAwMDAwIG4gCjAwMDAwMDE5MjAgMDAwMDAgbiAKMDAwMDAwMTk2NCAwMDAwMCBuIAp0cmFpbGVyCjw8L1Jvb3QgNiAwIFIvSUQgWzw4YzQ3ODA2ZjlmNDE4YjI2ZjIwZGFhOThkNjMyMjczOD48ZjdhMzdkMmY3MGU4ZmNlNDM2ZGM0NmQzYjM2NjYxNzE+XS9JbmZvIDcgMCBSL1NpemUgOD4+CnN0YXJ0eHJlZgoyMTEzCiUlRU9G"
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }
    // } else {
    //   handleError(response: response, message: 'Failed to verify email');
    // }
  }
}
