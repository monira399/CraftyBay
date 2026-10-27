import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../order/presentation/provider/order_provider.dart';
import '../../widgets/address_field.dart';
import '../../widgets/address_summary.dart';
import '../../widgets/checkout_card.dart';
import '../../widgets/checkout_icon_box.dart';
import '../../widgets/checkout_section_title.dart';
import '../../widgets/payment_option.dart';
import '../../widgets/place_order_button.dart';
import '../../widgets/price_row.dart';
import '../provider/cart_provider.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static String name = '/checkout';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  bool _isEditingAddress = false;
  String _selectedPaymentMethod = 'cod';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final cartProvider = context.watch<CartItemProvider>();

    final subTotal = cartProvider.totalPrice;
    final deliveryCharge = cartProvider.deliveryCharge;
    final finalTotal = cartProvider.finalTotal;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),

      appBar: AppBar(
        title: Text(
          'Checkout',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            CheckoutSectionTitle(
              title: 'Delivery Address',
              icon: Icons.location_on_outlined,
              textTheme: textTheme,
            ),

            const SizedBox(height: 12),

            CheckoutCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CheckoutIconBox(
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(width: 12),

                      AddressSummary(
                        textTheme: textTheme,
                        isEditingAddress: _isEditingAddress,
                        address: _addressController.text,
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isEditingAddress = !_isEditingAddress;
                          });
                        },
                        icon: Icon(
                          _isEditingAddress ? Icons.close : Icons.edit_outlined,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ],
                  ),

                  if (_isEditingAddress) ...[
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),

                    Form(
                      key: _addressFormKey,
                      child: Column(
                        children: [

                          AddressField(
                            controller: _nameController,
                            label: 'Full Name',
                            icon: Icons.person_outline,
                          ),
                          SizedBox(height: 10,),

                          AddressField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 10,),

                          AddressField(
                            controller: _cityController,
                            label: 'City',
                            icon: Icons.location_city,
                          ),
                          const SizedBox(height: 10),

                          AddressField(
                            controller: _postalCodeController,
                            label: 'Postal Code',
                            icon: Icons.local_post_office_outlined,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),

                          AddressField(
                            controller: _addressController,
                            label: 'Full Address',
                            icon: Icons.location_on_outlined,
                            maxLines: 3,
                          ),

                          const SizedBox(height: 16),

                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: _saveAddress,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.themeColor,
                                foregroundColor: Colors.black87,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Save Address'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment Method
            CheckoutSectionTitle(
              title: 'Payment Method',
              icon: Icons.payment,
              textTheme: textTheme,
            ),

            const SizedBox(height: 12),

            CheckoutCard(
              child: Column(
                children: [
                  PaymentOption(
                    title: 'Cash on Delivery',
                    subtitle: 'Pay when your order arrives',
                    icon: Icons.money,
                    value: 'cod',
                    selectedPaymentMethod: _selectedPaymentMethod,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),

                  const Divider(height: 24),

                  PaymentOption(
                    title: 'Online Payment',
                    subtitle: 'Pay securely online',
                    icon: Icons.money,
                    value: 'online',
                    selectedPaymentMethod: _selectedPaymentMethod,
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Order Summary
            CheckoutSectionTitle(
              title: 'Order Summary',
              icon: Icons.payment,
              textTheme: textTheme,
            ),

            const SizedBox(height: 12),

            CheckoutCard(
              child: Column(
                children: [
                  PriceRow(
                    title: 'Subtotal',
                    price: subTotal,
                    textTheme: textTheme,
                  ),

                  const SizedBox(height: 14),

                  PriceRow(
                    title: 'Delivery Charge',
                    price: deliveryCharge,
                    textTheme: textTheme,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1),
                  ),

                  PriceRow(
                    title: 'Total',
                    price: finalTotal,
                    textTheme: textTheme,
                    isTotal: true,
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Place Order Button
      bottomNavigationBar: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          return PlaceOrderButton(
            textTheme: textTheme,
            isLoading: provider.isLoading,
            onPressed: _onTapOrderButton
          );
        }
      ),
    );
  }

  // Save Address
  void _saveAddress() {
    if (_addressFormKey.currentState!.validate()) {
      setState(() {
        _isEditingAddress = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address validated successfully')),
      );
    }
  }

  void _onTapOrderButton()  {
    _placeOrder();
  }

  Future<void> _placeOrder() async {
    final orderProvider = context.read<OrderProvider>();

    final success = await orderProvider.createOrder(
      paymentMethod: _selectedPaymentMethod,
      shippingAddress: {
        'full_name': _nameController.text.trim(),
        'address': _addressController.text.trim(),
        'city': _cityController.text.trim(),
        'postal_code': _postalCodeController.text.trim(),
        'phone': _phoneController.text.trim(),
      },
      redirectUrl: 'https://jsonplaceholder.typicode.com/posts',
    );

    if (!context.mounted) return;

    if (success) {
    Navigator.pushReplacementNamed(context, OrderSuccessScreen.name, arguments: orderProvider.createdOrder);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            orderProvider.errorMessage ?? 'Order failed',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }
}
