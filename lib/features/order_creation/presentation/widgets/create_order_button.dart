import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_bloc.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_retried.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_status.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_submitted.dart';

class CreateOrderButton extends StatelessWidget {
  final int userId;
  final int serviceId;
  final OrderCreateState state;

  const CreateOrderButton({
    super.key,
    required this.userId,
    required this.serviceId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoading = state.status == OrderCreateStatus.loading;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                if (state.status == OrderCreateStatus.error) {
                  context.read<OrderCreateBloc>().add(
                        OrderCreateRetried(
                          userId: userId,
                          serviceId: serviceId,
                        ),
                      );
                  return;
                }
                context.read<OrderCreateBloc>().add(
                      OrderCreateSubmitted(
                        userId: userId,
                        serviceId: serviceId,
                      ),
                    );
              },
        child: const Text('Создать заказ'),
      ),
    );
  }
}
