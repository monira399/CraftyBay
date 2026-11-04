
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order_provider.dart';
import '../widgets/empty_order_widget.dart';
import '../widgets/order_card.dart';
import '../widgets/order_error_widget.dart';
import '../widgets/order_helper.dart';
import '../widgets/order_tab_widget.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedTab = 0;
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().getOrderHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: _isSearching
            ? TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search order...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        )
            : const Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                }
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Row(
            children: [
              OrderTabWidget(
                title: 'All',
                index: 0,
                selectedTab: _selectedTab,
                primaryColor: primaryColor,
                onTap: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
              OrderTabWidget(
                title: 'Active',
                index: 1,
                selectedTab: _selectedTab,
                primaryColor: primaryColor,
                onTap: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
              OrderTabWidget(
                title: 'Completed',
                index: 2,
                selectedTab: _selectedTab,
                primaryColor: primaryColor,
                onTap: (index) {
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),

      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.orderList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.errorMessage != null &&
              provider.orderList.isEmpty) {
            return OrderErrorWidget(
              message: provider.errorMessage!,
              primaryColor: primaryColor,
            );
          }

          final orders = OrderHelper.filterOrders(
            provider.orderList,
            _selectedTab,
            _searchQuery,
          );

          if (orders.isEmpty) {
            return const EmptyOrderWidget();
          }

          return RefreshIndicator(
            color: primaryColor,
            onRefresh: () => provider.getOrderHistory(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return OrderCard(
                  order: orders[index],
                  primaryColor: primaryColor,
                );
              },
            ),
          );
        },
      ),
    );
  }


}
