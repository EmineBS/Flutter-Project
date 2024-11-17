import 'package:dio/dio.dart';
import '../models/category.dart';
import '../models/product.dart';

class CategoryService {
  final Dio _dio = Dio();
  final String apiUrl;

  CategoryService({required this.apiUrl});

  // Fetch all categories
  Future<List<Category>> fetchCategories() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"];
        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<Product>> fetchCategoryProducts(int categoryId) async {
    try {
      Response response = await _dio.get('$apiUrl/$categoryId/products');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"];
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products for category $categoryId');
      }
    } catch (e) {
      throw Exception('Error fetching products for category $categoryId: $e');
    }
  }

  // Get category by ID
  Future<Category> fetchCategoryById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return Category.fromJson(response.data["data"]);
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }

  // Create a new category
  Future<Category> createCategory(Category category) async {
    try {
      Response response = await _dio.post(apiUrl, data: category.toJson());

      if (response.statusCode == 201) {
        return Category.fromJson(response.data);
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  // Update a category by ID
  Future<Category> updateCategory(int id, Category category) async {
    try {
      Response response =
          await _dio.put('$apiUrl/$id', data: category.toJson());

      if (response.statusCode == 200) {
        return Category.fromJson(response.data);
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  // Delete a category by ID
  Future<void> deleteCategory(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete category');
      }
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }
}
