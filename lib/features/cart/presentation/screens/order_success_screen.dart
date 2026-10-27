
import 'package:craftybay/app/app_colors.dart';
import 'package:craftybay/features/common/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderData});

  final Map<String, dynamic> orderData;

  static const String name = '/order-success';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final orderId = orderData['_id']?.toString() ?? 'N/A';
    final totalPrice = orderData['total_price']?.toString() ?? '0';
    final paymentMethod = orderData['payment_method'] ?? 'N/A';
    final paymentStatus = orderData['payment_status'] ?? 'pending';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),

              // Success Icon
              Center(
                child: Container(
                  height: 112,
                  width: 112,
                  decoration: BoxDecoration(
                    color: AppColors.themeColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 76,
                    color: AppColors.themeColor,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Success Message
              Text(
                'Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Thank you for shopping with CraftyBay. '
                    'Your order has been placed successfully.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Order Details Card
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Details',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildDetailRow(
                        context,
                        'Order ID',
                        orderId,
                      ),

                      const SizedBox(height: 16),

                      _buildDetailRow(
                        context,
                        'Payment Method',
                      paymentMethod
                      ),

                      const SizedBox(height: 16),

                      _buildDetailRow(
                        context,
                        'Payment Status',
                         paymentStatus,
                        valueColor: Colors.orange.shade700,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Divider(),
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                          totalPrice,
                            style: textTheme.titleLarge?.copyWith(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Continue Shopping
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MainNavHolderScreen.name,
                          (route) => false,
                    );
                  },
                  child: const Text('Continue Shopping'),
                ),
              ),

              const SizedBox(height: 12),

              // Back to Shopping
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MainNavHolderScreen.name,
                          (route) => false,
                    );
                  },
                  child: const Text('Back to Home'),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context,
      String label,
      String value, {
        Color? valueColor,
      }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
