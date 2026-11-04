
import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderHelper {

  static List<OrderModel> filterOrders(
      List<OrderModel> orders,
      int selectedTab,
      String searchQuery,
      ) {
    List<OrderModel> filteredOrders = orders;

    if (selectedTab == 1) {
      filteredOrders = filteredOrders.where((order) {
        final status = order.status.toLowerCase();

        return status != 'completed' &&
            status != 'delivered' &&
            status != 'cancelled';
      }).toList();
    } else if (selectedTab == 2) {
      filteredOrders = filteredOrders.where((order) {
        final status = order.status.toLowerCase();

        return status == 'completed' ||
            status == 'delivered';
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredOrders = filteredOrders.where((order) {
        return order.id.toLowerCase().contains(
          searchQuery.toLowerCase(),
        ) ||
            (order.transactionId ?? '').toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
      }).toList();
    }

    return filteredOrders;
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      case 'pending':
      case 'processing':
      case 'in_progress':
      case 'shipped':
        return Colors.orange;

      default:
        return Colors.blueGrey;
    }
  }

  static String formatStatus(String status) {
    if (status.isEmpty) return 'Unknown';

    return status
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isEmpty
        ? ''
        : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  static String formatDate(DateTime? date) {
    if (date == null) return 'Date unavailable';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
