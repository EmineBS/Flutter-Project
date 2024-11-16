import 'package:dio/dio.dart';
import '../models/commandeproduct.dart';

class CommandeProductService {
  final Dio _dio = Dio();
  final String apiUrl;

  CommandeProductService({required this.apiUrl});

  // Fetch all commande products
  Future<List<CommandeProduct>> fetchCommandeProducts() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CommandeProduct.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load commande products');
      }
    } catch (e) {
      throw Exception('Error fetching commande products: $e');
    }
  }

  // Get commande product by ID
  Future<CommandeProduct> fetchCommandeProductById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return CommandeProduct.fromJson(response.data);
      } else {
        throw Exception('Failed to load commande product');
      }
    } catch (e) {
      throw Exception('Error fetching commande product: $e');
    }
  }

  // Create a new commande product
  Future<CommandeProduct> createCommandeProduct(
      CommandeProduct commandeProduct) async {
    try {
      Response response =
          await _dio.post(apiUrl, data: commandeProduct.toJson());

      if (response.statusCode == 201) {
        return CommandeProduct.fromJson(response.data);
      } else {
        throw Exception('Failed to create commande product');
      }
    } catch (e) {
      throw Exception('Error creating commande product: $e');
    }
  }

  // Update a commande product by ID
  Future<CommandeProduct> updateCommandeProduct(
      int id, CommandeProduct commandeProduct) async {
    try {
      Response response =
          await _dio.put('$apiUrl/$id', data: commandeProduct.toJson());

      if (response.statusCode == 200) {
        return CommandeProduct.fromJson(response.data);
      } else {
        throw Exception('Failed to update commande product');
      }
    } catch (e) {
      throw Exception('Error updating commande product: $e');
    }
  }

  // Delete a commande product by ID
  Future<void> deleteCommandeProduct(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete commande product');
      }
    } catch (e) {
      throw Exception('Error deleting commande product: $e');
    }
  }
}
