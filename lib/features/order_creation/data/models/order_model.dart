import 'package:teccod_test_task/features/order_creation/domain/entities/order.dart';

class OrderModel {
  final int orderId;
  final String status;
  final String? paymentUrl;

  const OrderModel({
    required this.orderId,
    required this.status,
    required this.paymentUrl,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final dynamic orderIdValue = json['order_id'];
    final dynamic statusValue = json['status'];
    final dynamic paymentUrlValue = json['payment_url'];

    if (orderIdValue is! int) {
      throw const FormatException('Field order_id must be int.');
    }
    if (statusValue is! String) {
      throw const FormatException('Field status must be string.');
    }
    if (paymentUrlValue != null && paymentUrlValue is! String) {
      throw const FormatException('Field payment_url must be string or null.');
    }

    return OrderModel(
      orderId: orderIdValue,
      status: statusValue,
      paymentUrl: paymentUrlValue as String?,
    );
  }

  Order toEntity() {
    return Order(orderId: orderId, status: status, paymentUrl: paymentUrl);
  }
}
