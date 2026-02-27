import 'package:flutter/material.dart';
import 'package:teccod_test_task/core/network/network_exceptions.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_error_view.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_initial_view.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_loading_view.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_success_view.dart';

class OrderStateSection extends StatelessWidget {
  final OrderCreateState state;

  const OrderStateSection({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.status == OrderCreateStatus.loading) {
      return const OrderLoadingView();
    }
    if (state.status == OrderCreateStatus.error) {
      final String message =
          state.errorMessage ?? NetworkExceptionMessages.createOrderFailed;
      return OrderErrorView(message: message);
    }
    if (state.status == OrderCreateStatus.success) {
      if (state.order == null) {
        return const OrderErrorView(
          message: NetworkExceptionMessages.createOrderFailed,
        );
      }
      return OrderSuccessView(order: state.order!);
    }
    return const OrderInitialView();
  }
}
