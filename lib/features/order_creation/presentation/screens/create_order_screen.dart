import 'package:flutter/material.dart';
import 'package:teccod_test_task/features/order_creation/presentation/widgets/order_content.dart';

class CreateOrderScreen extends StatelessWidget {
  final int userId;
  final int serviceId;

  const CreateOrderScreen({
    super.key,
    required this.userId,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание заказа'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: OrderContent(
          userId: userId,
          serviceId: serviceId,
        ),
      ),
    );
  }
}
