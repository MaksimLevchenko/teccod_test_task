import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';

abstract class OrderRemoteDataSource {
  Future<Order> createOrder(int userId, int serviceId);
}
