import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:teccod_test_task/core/network/api_exception.dart';
import 'package:teccod_test_task/core/network/error_parser.dart';
import 'package:teccod_test_task/core/network/http_api_client.dart';
import 'package:teccod_test_task/core/network/network_exceptions.dart';
import 'package:teccod_test_task/features/order_creation/data/datasources/order_remote_data_source.dart';
import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final HttpApiClient _httpApiClient;
  final ErrorParser _errorParser;

  const OrderRemoteDataSourceImpl({
    required HttpApiClient httpApiClient,
    required ErrorParser errorParser,
  })  : _httpApiClient = httpApiClient,
        _errorParser = errorParser;

  @override
  Future<Order> createOrder(int userId, int serviceId) async {
    try {
      final response = await _httpApiClient.postJson(
        '/api/orders',
        body: <String, dynamic>{
          'userId': userId,
          'serviceId': serviceId,
        },
      );

      if (response.statusCode == 200) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is! Map) {
          throw const FormatException('Response body must be JSON object.');
        }
        return Order.fromJson(Map<String, dynamic>.from(decoded));
      }

      if (response.statusCode >= 400) {
        final String message = _errorParser.parse(
          response.body,
          fallbackMessage: NetworkExceptionMessages.createOrderFailed,
        );
        throw ApiException(
          message,
          statusCode: response.statusCode,
          details: response.body,
        );
      }

      final String message = _errorParser.parse(
        response.body,
        fallbackMessage: NetworkExceptionMessages.createOrderFailed,
      );
      throw ApiException(
        message,
        statusCode: response.statusCode,
        details: response.body,
      );
    } on ApiException catch (error, stackTrace) {
      log(
        'createOrder failed with ApiException: ${error.toString()}',
        name: 'OrderRemoteDataSourceImpl',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } on SocketException catch (error, stackTrace) {
      log(
        'createOrder failed with SocketException: ${error.toString()}',
        name: 'OrderRemoteDataSourceImpl',
        error: error,
        stackTrace: stackTrace,
      );
      throw ApiException(
        NetworkExceptionMessages.noInternet,
        details: error,
      );
    } on TimeoutException catch (error, stackTrace) {
      log(
        'createOrder failed with TimeoutException: ${error.toString()}',
        name: 'OrderRemoteDataSourceImpl',
        error: error,
        stackTrace: stackTrace,
      );
      throw ApiException(
        NetworkExceptionMessages.requestTimeout,
        details: error,
      );
    } on FormatException catch (error, stackTrace) {
      log(
        'createOrder failed with FormatException: ${error.toString()}',
        name: 'OrderRemoteDataSourceImpl',
        error: error,
        stackTrace: stackTrace,
      );
      throw ApiException(
        NetworkExceptionMessages.invalidResponse,
        details: error,
      );
    } catch (error, stackTrace) {
      log(
        'createOrder failed with unexpected error: ${error.toString()}',
        name: 'OrderRemoteDataSourceImpl',
        error: error,
        stackTrace: stackTrace,
      );
      throw ApiException(
        NetworkExceptionMessages.createOrderFailed,
        details: error,
      );
    }
  }
}
