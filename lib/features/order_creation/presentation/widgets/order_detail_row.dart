import 'package:flutter/material.dart';

class OrderDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const OrderDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
