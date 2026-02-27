class Order {
  final int orderId;
  final String status;
  final String? paymentUrl;

  const Order({
    required this.orderId,
    required this.status,
    required this.paymentUrl,
  });

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
