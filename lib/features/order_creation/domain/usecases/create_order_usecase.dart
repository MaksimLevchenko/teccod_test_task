import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/domain/repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository _orderRepository;

  const CreateOrderUseCase({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  Future<Order> call(int userId, int serviceId) {
    return _orderRepository.createOrder(userId, serviceId);
  }
}
