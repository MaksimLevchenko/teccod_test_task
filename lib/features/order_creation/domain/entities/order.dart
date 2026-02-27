class Order {
  final int orderId;
  final String status;
  final String? paymentUrl;

  const Order({
    required this.orderId,
    required this.status,
    required this.paymentUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
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

    return Order(
      orderId: orderIdValue,
      status: statusValue,
      paymentUrl: paymentUrlValue as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Order &&
        other.orderId == orderId &&
        other.status == status &&
        other.paymentUrl == paymentUrl;
  }

  @override
  int get hashCode => Object.hash(orderId, status, paymentUrl);
}
