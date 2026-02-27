import 'package:teccod_test_task/features/order_creation/presentation/bloc/order_create_event.dart';

class OrderCreateSubmitted extends OrderCreateEvent {
  @override
  final int userId;
  @override
  final int serviceId;

  const OrderCreateSubmitted({
    required this.userId,
    required this.serviceId,
  });
}
