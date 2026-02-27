import 'package:flutter/material.dart';

class OrderErrorView extends StatelessWidget {
  final String message;

  const OrderErrorView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
