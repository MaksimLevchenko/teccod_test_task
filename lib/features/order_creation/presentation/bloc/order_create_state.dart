import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';

abstract class OrderCreateState {
  final OrderCreateStatus status;
  final Order? order;
  final String? errorMessage;

  const OrderCreateState({
    required this.status,
    this.order,
    this.errorMessage,
  });
}
