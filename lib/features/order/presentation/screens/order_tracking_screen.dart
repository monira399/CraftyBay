
import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderModel order;

  const OrderTrackingScreen({
    super.key,
    required this.order,
  });

  static String name = '/order-tracking';

  static const Color _successColor = Color(0xFF28B968);

  static const List<Map<String, String>> _steps = [
    {
      'title': 'Placed',
      'description': 'We have received your order.',
    },
    {
      'title': 'Processing',
      'description': 'Your order is being prepared.',
    },
    {
      'title': 'Shipped',
      'description': 'Your order is on the way.',
    },
    {
      'title': 'Delivered',
      'description': 'Your order has been delivered.',
    },
  ];

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int get _currentStep {
    switch (widget.order.status.toLowerCase().trim()) {
      case 'pending':
        return 0;
      case 'processing':
        return 1;
      case 'shipped':
      case 'in_transit':
      case 'in transit':
        return 2;
      case 'delivered':
      case 'completed':
        return 3;
      default:
        return 0;
    }
  }

  String get _statusTitle {
    switch (widget.order.status.toLowerCase().trim()) {
      case 'pending':
        return 'Order Placed';
      case 'processing':
        return 'Order Processing';
      case 'shipped':
      case 'in_transit':
      case 'in transit':
        return 'Order Shipped';
      case 'delivered':
      case 'completed':
        return 'Order Delivered';
      case 'cancelled':
        return 'Order Cancelled';
      default:
        return widget.order.status;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date unavailable';

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime? date) {
    if (date == null) return '';

    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  String _formatAmount(num amount) {
    return '৳${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isCancelled =
        widget.order.status.toLowerCase().trim() == 'cancelled';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Order Tracking',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              _buildOrderHeader(theme),

              const SizedBox(height: 24),

              // Status and Delivery Cards
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      theme: theme,
                      icon: Icons.inventory_2_outlined,
                      iconColor: isCancelled
                          ? Colors.red
                          : OrderTrackingScreen._successColor,
                      backgroundColor: isCancelled
                          ? Colors.red.withValues(alpha: 0.08)
                          : OrderTrackingScreen._successColor.withValues(alpha: 0.12),
                      label: 'Status',
                      value: _statusTitle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      theme: theme,
                      icon: Icons.calendar_month_outlined,
                      iconColor: primaryColor,
                      backgroundColor:
                      primaryColor.withValues(alpha: 0.10),
                      label: 'Estimated delivery',
                      value: 'Awaiting update',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Tracking Timeline
              Text(
                'Tracking Details',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 22),

              if (isCancelled)
                _buildCancelledMessage(theme)
              else
                _buildTimeline(theme),

              const SizedBox(height: 28),

              // Order Summary
              _buildOrderSummary(theme),

              const SizedBox(height: 18),

              // Payment Information
              _buildPaymentInfo(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track order #${widget.order.id}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _formatDate(widget.order.createdAt),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
          ),
        ),
        if (widget.order.transactionId != null &&
            widget.order.transactionId!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Transaction ID: ${widget.order.transactionId}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoCard({
    required ThemeData theme,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String label,
    required String value,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 118),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 23),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(ThemeData theme) {
    final primaryColor = theme.colorScheme.primary;

    return Column(
      children: List.generate(OrderTrackingScreen._steps.length, (index) {
        final isCompleted = index <= _currentStep;
        final isLast = index == OrderTrackingScreen._steps.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline Indicator
              SizedBox(
                width: 38,
                child: Column(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? OrderTrackingScreen._successColor
                            : theme.colorScheme.surface,
                        border: isCompleted
                            ? null
                            : Border.all(
                          color: theme.dividerColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check
                            : Icons.circle_outlined,
                        size: 19,
                        color: isCompleted
                            ? Colors.white
                            : theme.hintColor,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 3,
                          color: index < _currentStep
                              ? OrderTrackingScreen._successColor
                              : theme.dividerColor,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Timeline Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : 32,
                    top: 1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              OrderTrackingScreen._steps[index]['title']!,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (index == 0)
                            Text(
                              _formatTime(widget.order.createdAt),
                              style: theme.textTheme.bodySmall,
                            ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        OrderTrackingScreen._steps[index]['description']!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.70),
                        ),
                      ),
                      if (index > 0 && !isCompleted) ...[
                        const SizedBox(height: 5),
                        Text(
                          'Waiting for update',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCancelledMessage(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.cancel_outlined, color: Colors.red, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'This order has been cancelled.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(ThemeData theme) {
    return _buildSectionCard(
      theme: theme,
      title: 'Order Summary',
      icon: Icons.receipt_long_outlined,
      children: [
        _buildDetailRow(
          theme,
          'Order ID',
          '#${widget.order.id}',
        ),
        _buildDetailRow(
          theme,
          'Total Items',
          '${widget.order.totalItems}',
        ),
        _buildDetailRow(
          theme,
          'Order Date',
          _formatDate(widget.order.createdAt),
        ),
        const Divider(height: 22),
        _buildDetailRow(
          theme,
          'Total Amount',
          _formatAmount(widget.order.totalPrice),
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildPaymentInfo(ThemeData theme) {
    return _buildSectionCard(
      theme: theme,
      title: 'Payment Information',
      icon: Icons.payment_outlined,
      children: [
        _buildDetailRow(
          theme,
          'Payment Method',
          widget.order.paymentMethod.toUpperCase(),
        ),
        _buildDetailRow(
          theme,
          'Payment Status',
          widget.order.paymentStatus.toUpperCase(),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required ThemeData theme,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      ThemeData theme,
      String label,
      String value, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isBold
                    ? FontWeight.w800
                    : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
