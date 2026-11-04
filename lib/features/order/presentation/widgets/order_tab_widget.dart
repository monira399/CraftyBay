
import 'package:flutter/material.dart';

class OrderTabWidget extends StatelessWidget {
  final String title;
  final int index;
  final int selectedTab;
  final Color primaryColor;
  final ValueChanged<int> onTap;

  const OrderTabWidget({
    super.key,
    required this.title,
    required this.index,
    required this.selectedTab,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? primaryColor
                  : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
