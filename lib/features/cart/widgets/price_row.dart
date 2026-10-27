
import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.title,
    required this.price,
    required this.textTheme,
    this.isTotal = false,
  });

  final String title;
  final num price;
  final TextTheme textTheme;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight:
            isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          '৳ ${price.toStringAsFixed(2)}',
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
