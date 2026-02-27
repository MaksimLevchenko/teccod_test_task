import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:teccod_test_task/core/network/api_exception.dart';
import 'package:teccod_test_task/core/network/error_parser.dart';
import 'package:teccod_test_task/core/network/http_api_client.dart';
import 'package:teccod_test_task/core/network/network_exceptions.dart';
import 'package:teccod_test_task/features/order_creation/data/datasources/order_remote_data_source.dart';
import 'package:teccod_test_task/features/order_creation/data/models/order_model.dart';
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
        if (decoded is! Map<String, dynamic>) {
          throw const FormatException('Response body must be JSON object.');
        }
        final OrderModel model = OrderModel.fromJson(decoded);
        return model.toEntity();
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
    } on ApiException {
      rethrow;
    } on SocketException catch (error) {
      throw ApiException(
        NetworkExceptionMessages.noInternet,
        details: error,
      );
    } on TimeoutException catch (error) {
      throw ApiException(
        NetworkExceptionMessages.requestTimeout,
        details: error,
      );
    } on FormatException catch (error) {
      throw ApiException(
        NetworkExceptionMessages.invalidResponse,
        details: error,
      );
    } catch (error) {
      throw ApiException(
        NetworkExceptionMessages.createOrderFailed,
        details: error,
      );
    }
  }
}
