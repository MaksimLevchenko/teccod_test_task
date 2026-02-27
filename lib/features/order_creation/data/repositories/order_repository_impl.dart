import 'package:teccod_test_task/features/order_creation/data/datasources/order_remote_data_source.dart';
import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;

  const OrderRepositoryImpl({
    required OrderRemoteDataSource orderRemoteDataSource,
  }) : _orderRemoteDataSource = orderRemoteDataSource;

  @override
  Future<Order> createOrder(int userId, int serviceId) {
    return _orderRemoteDataSource.createOrder(userId, serviceId);
  }
}
