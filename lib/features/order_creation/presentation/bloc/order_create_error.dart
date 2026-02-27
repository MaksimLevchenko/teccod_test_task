import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';

class OrderCreateError extends OrderCreateState {
  const OrderCreateError({required String errorMessage})
      : super(status: OrderCreateStatus.error, errorMessage: errorMessage);
}
