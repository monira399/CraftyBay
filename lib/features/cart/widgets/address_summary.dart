
import 'package:flutter/material.dart';

class AddressSummary extends StatelessWidget {
  const AddressSummary({
    super.key,
    required this.textTheme,
    required this.isEditingAddress,
    required this.address,
  });

  final TextTheme textTheme;
  final bool isEditingAddress;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Home',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isEditingAddress
                ? 'Edit your delivery address'
                : address.isEmpty
                ? 'Add your delivery address'
                : address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
