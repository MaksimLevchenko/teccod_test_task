import 'package:flutter/material.dart';
import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_detail_row.dart';

class OrderSuccessView extends StatelessWidget {
  final Order order;

  const OrderSuccessView({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final String paymentUrlText = order.paymentUrl ?? 'нет ссылки';
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OrderDetailRow(
                label: 'orderId',
                value: order.orderId.toString(),
              ),
              const SizedBox(height: 8),
              OrderDetailRow(
                label: 'status',
                value: order.status,
              ),
              const SizedBox(height: 8),
              OrderDetailRow(
                label: 'paymentUrl',
                value: paymentUrlText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
