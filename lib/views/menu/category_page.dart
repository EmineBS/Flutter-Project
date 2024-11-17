import 'package:flutter/material.dart';
import 'package:grocery/core/models/dummy_product_model.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile.dart';
import '../../core/constants/constants.dart';
import 'package:grocery/views/auth/components/not_found_dialog.dart';
import 'package:grocery/services/category_service.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/core/config/api_constants.dart';

class CategoryProductPage extends StatefulWidget {
  final String? label;

  const CategoryProductPage({super.key, this.label});

  @override
  _CategoryProductPageState createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  List<Product> _products = []; // Store the list of products

  Future<void> getCategoryProducts() async {
    try {
      const apiUrl = '${ApiConstants.baseUrl}/category/categories';
      CategoryService categoryService = CategoryService(apiUrl: apiUrl);
      final result = await categoryService.fetchCategoryProducts(2);

      if (result.isNotEmpty) {
        setState(() {
          _products = result;
        });
      }
    } catch (e) {
      print('Error fetching category products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryProducts(); // Call the function to fetch products on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label ?? 'Category Details'),
        leading: const AppBackButton(),
      ),
      body: _products.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Loading indicator while data is being fetched
          : GridView.builder(
              padding: const EdgeInsets.only(top: AppDefaults.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ProductTileSquare(
                    data: _products[index], label: widget.label);
              },
            ),
    );
  }
}
