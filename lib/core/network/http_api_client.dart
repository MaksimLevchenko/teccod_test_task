import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teccod_test_task/core/config/app_config.dart';

class HttpApiClient {
  final http.Client _client;
  final AppConfig _appConfig;

  HttpApiClient({
    required http.Client client,
    required AppConfig appConfig,
  })  : _client = client,
        _appConfig = appConfig;

  Future<http.Response> postJson(
    String path, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final Uri uri = Uri.parse(_appConfig.baseUrl).resolve(path);
    final Map<String, String> requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (headers != null) {
      requestHeaders.addAll(headers);
    }
    return _client
        .post(uri, headers: requestHeaders, body: jsonEncode(body))
        .timeout(const Duration(seconds: 10));
  }
}
