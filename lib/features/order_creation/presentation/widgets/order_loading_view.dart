import 'package:flutter/material.dart';

class OrderLoadingView extends StatelessWidget {
  const OrderLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
