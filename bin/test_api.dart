import 'package:grocery/services/product_service.dart';
import 'package:grocery/services/category_service.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/core/config/api_constants.dart';

void main() async {
  const apiUrl = '${ApiConstants.baseUrl}/category/categories';
  final categoryService = CategoryService(apiUrl: apiUrl);

  try {
    List<Product> products = await categoryService.fetchCategoryProducts(2);
    print('Category fetched successfully:\n');

    for (Product product in products) {
      print(
          'ID: ${product.id}, Name: ${product.name}, pricePerDetail: ${product.pricePerDetail}, priceWholesale: ${product.priceWholesale}, categoryId: ${product.categoryId}');
      //'ID: ${category.id}, Name: ${category.name}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
