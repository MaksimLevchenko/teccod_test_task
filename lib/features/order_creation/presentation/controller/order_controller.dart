import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:teccod_test_task/core/network/api_exception.dart';
import 'package:teccod_test_task/core/network/network_exceptions.dart';
import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/domain/usecases/create_order_usecase.dart';
import 'package:teccod_test_task/features/order_creation/presentation/controller/order_controller_state.dart';

class OrderController extends ChangeNotifier {
  final CreateOrderUseCase _createOrderUseCase;

  OrderController({
    required CreateOrderUseCase createOrderUseCase,
  }) : _createOrderUseCase = createOrderUseCase;

  OrderControllerState _state = OrderControllerState.initial;
  Order? _order;
  String? _errorMessage;

  OrderControllerState get state => _state;
  Order? get order => _order;
  String? get errorMessage => _errorMessage;

  Future<void> submitOrder(int userId, int serviceId) async {
    if (_state == OrderControllerState.loading) {
      return;
    }
    _state = OrderControllerState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final Order createdOrder = await _createOrderUseCase(userId, serviceId);
      _order = createdOrder;
      _state = OrderControllerState.success;
      notifyListeners();
    } on ApiException catch (error, stackTrace) {
      log(
        'submitOrder failed: ${error.toString()}',
        name: 'OrderController',
        error: error,
        stackTrace: stackTrace,
      );
      _order = null;
      _errorMessage = error.message;
      _state = OrderControllerState.error;
      notifyListeners();
    } catch (error, stackTrace) {
      log(
        'submitOrder failed with unexpected error: ${error.toString()}',
        name: 'OrderController',
        error: error,
        stackTrace: stackTrace,
      );
      _order = null;
      _errorMessage = NetworkExceptionMessages.createOrderFailed;
      _state = OrderControllerState.error;
      notifyListeners();
    }
  }
}
