import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';

class OrderCreateInitial extends OrderCreateState {
  const OrderCreateInitial() : super(status: OrderCreateStatus.initial);
}
