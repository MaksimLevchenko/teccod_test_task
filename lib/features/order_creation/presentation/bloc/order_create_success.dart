import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';

class OrderCreateSuccess extends OrderCreateState {
  OrderCreateSuccess({required Order order})
      : super(status: OrderCreateStatus.success, order: order);
}
