import 'package:grocery/services/product_service.dart';
import 'package:grocery/models/product.dart';

void main() async {
  final productService =
      ProductService(apiUrl: 'http://localhost:3000/product/products');

  try {
    List<Product> products = await productService.fetchProducts();
    print('Products fetched successfully:\n');

    for (Product product in products) {
      print(
          'ID: ${product.id}, Name: ${product.name}, pricePerDetail: \$${product.pricePerDetail}, priceWholesale: \$${product.priceWholesale}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
