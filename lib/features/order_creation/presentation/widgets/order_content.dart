import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_bloc.dart';
import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_state.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/create_order_button.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_state_section.dart';

class OrderContent extends StatelessWidget {
  final int userId;
  final int serviceId;

  const OrderContent({
    super.key,
    required this.userId,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCreateBloc, OrderCreateState>(
      builder: (BuildContext context, OrderCreateState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: OrderStateSection(state: state),
            ),
            const SizedBox(height: 16),
            CreateOrderButton(
              userId: userId,
              serviceId: serviceId,
              state: state,
            ),
          ],
        );
      },
    );
  }
}
