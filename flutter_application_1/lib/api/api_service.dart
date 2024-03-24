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

  /// The url to be used for the WebSocket calls (wss://websocket.wizz.life/ws)

  static const String irisUrl = devMode ? 'ws://192.168.50.218:8000/ws' : 'wss://websocket.wizz.life/ws';

  /// The url to be used for the api calls (https://iris-back.wizz.life/api)
  /// The url to be used for LOCAL the api calls (http://127.0.0.1:8000/api)
  static const String irisApi = devMode ? 'http://192.168.50.218:8000/api' : "https://iris-back.wizz.life/api";

  /// The url to be used for the testing api calls (https://staging.wizz.life/api)
  static const String irisStagingApi = devMode ? 'http://192.168.50.218:8000/api' : 'https://staging.wizz.life/api';

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
      if (withToken == true) HttpHeaders.authorizationHeader: 'Token ${getToken()}',
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  // For handle errors on every api call
  static void handleError({required dynamic response, required String message}) {
    String responseMessage = 'Unknown error';

    if (response != null) {
      try {
        int? statusCode;
        Map<String, dynamic>? responseBody;

        if (response is StreamedResponse) {
          final streamedResponse = response;
          statusCode = streamedResponse.statusCode;

          // Check if the status code is 500 or the response is HTML
          if (statusCode == 500 || streamedResponse.headers['content-type']?.contains('text/html') == true) {
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
          if (statusCode == 500 || response.headers['content-type']?.contains('text/html') == true) {
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

  Future loginButter({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('$irisApi/v1/api-token-auth/'),
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
}