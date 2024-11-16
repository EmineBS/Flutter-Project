import 'package:dio/dio.dart';
import '../models/product.dart';
import '../models/category.dart';

class ProductService {
  final Dio _dio = Dio();
  final String apiUrl;

  ProductService({required this.apiUrl});

  // Fetch all products
  Future<List<Product>> fetchProducts() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Get product by ID
  Future<Product> fetchProductById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  // Get product category by product ID
  Future<Category> fetchProductCategory(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id/category');

      if (response.statusCode == 200) {
        return Category.fromJson(response.data["data"]);
      } else {
        throw Exception('Failed to load product category');
      }
    } catch (e) {
      throw Exception('Error fetching product category: $e');
    }
  }

  // Create a new product
  Future<Product> createProduct(Product product) async {
    try {
      Response response = await _dio.post(apiUrl, data: product.toJson());

      if (response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  // Update a product by ID
  Future<Product> updateProduct(int id, Product product) async {
    try {
      Response response = await _dio.put('$apiUrl/$id', data: product.toJson());

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Delete a product by ID
  Future<void> deleteProduct(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
