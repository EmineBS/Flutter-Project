import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import 'package:grocery/services/product_service.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'components/product_detail.dart';
import 'package:intl/intl.dart';
import 'products_page.dart';
import 'components/add_product.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<Product> _products = [];
  bool _isLoading = true;

  Future<void> getCategoryProducts() async {
    try {
      final apiUrl = '${ApiConstants.baseUrl}/product/products';
      print(apiUrl);
      ProductService productService = ProductService(apiUrl: apiUrl);
      final result = await productService.fetchProducts();

      if (result.isNotEmpty) {
        setState(() {
          _products = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryProducts();
  }

  void _navigateToDetail(Product product) async {
    // Wait for the result from the CommandeDetailScreen (whether it's success or failure)
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );

    // Only proceed if the result is not null (success/failure)
    if (result == true) {
      getCategoryProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Action for panier icon
                  },
                  icon: const Icon(
                    Icons.store,
                    color: Colors.white,
                  ),
                ),
                //const SizedBox(width: 8),
                Text(
                  'Products',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Action for search button
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Main body content (including list and other widgets)
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    hintText: 'Products, Dates, Fournisseurs, ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  isExpanded: true,
                  value: null, // No default value
                  onChanged: (String? newValue) {
                    // Handle selection changes
                  },
                  items: <String>['Products', 'Dates', 'Fournisseurs', 'Categories']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              // ListView with items
              ProductsList(
                products: _products,
                onNavigateToDetail: _navigateToDetail,
              ),
            ],
          ),
          // Fixed Floating Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductScreen(),
                  ),
                );

                if (result == true) {
                  // Trigger refresh of commandes
                  await getCategoryProducts(); // Replace this with your actual method to refresh the commandes
                }
              },
              backgroundColor: AppColors.primary, // Your custom color
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
