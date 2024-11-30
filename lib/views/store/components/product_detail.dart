import 'package:flutter/material.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/core/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'package:grocery/services/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> deleteProduct(BuildContext context, int id) async {
    const apiUrl = '${ApiConstants.baseUrl}/product/products';
    ProductService productService = ProductService(apiUrl: apiUrl);

    try {
      await productService.deleteProduct(id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );
      Navigator.pop(context, true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product, Retry Again!')),
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            capitalize(label),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            onPressed: () {
              // Action for search button
              print('Search button pressed');
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name.toUpperCase() ?? 'Retail',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(product.createdAt)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                    onPressed: () async {
                      // Call the delete function and await it
                      await deleteProduct(context, product.id);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Details Section
        Column(
          children: [
            // Loop through products and create individual Containers for each
            Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          'Product',
                          product.name[0].toUpperCase() + product.name.substring(1),
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Price per gros',
                          '${product.priceWholesale ?? 'N/A'}',
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Price per detail',
                          '${product.pricePerDetail ?? 'N/A'}',
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Buy Date',
                          DateFormat('yyyy-MM-dd').format(product.buyDate),
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Expire Date',
                          DateFormat('yyyy-MM-dd').format(product.expireDate),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Space between products
                ],
              ),
          ],
        ),

        ],
        ),
      ),
    );
  }
}
