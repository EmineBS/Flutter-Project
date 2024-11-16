import 'package:dio/dio.dart';
import '../models/commande.dart';

class CommandeService {
  final Dio _dio = Dio();
  final String apiUrl;

  CommandeService({required this.apiUrl});

  // Fetch all commandes
  Future<List<Commande>> fetchCommandes() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Commande.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load commandes');
      }
    } catch (e) {
      throw Exception('Error fetching commandes: $e');
    }
  }

  // Get commande by ID
  Future<Commande> fetchCommandeById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return Commande.fromJson(response.data);
      } else {
        throw Exception('Failed to load commande');
      }
    } catch (e) {
      throw Exception('Error fetching commande: $e');
    }
  }

  // Create a new commande
  Future<Commande> createCommande(Commande commande) async {
    try {
      Response response = await _dio.post(apiUrl, data: commande.toJson());

      if (response.statusCode == 201) {
        return Commande.fromJson(response.data);
      } else {
        throw Exception('Failed to create commande');
      }
    } catch (e) {
      throw Exception('Error creating commande: $e');
    }
  }

  // Update a commande by ID
  Future<Commande> updateCommande(int id, Commande commande) async {
    try {
      Response response =
          await _dio.put('$apiUrl/$id', data: commande.toJson());

      if (response.statusCode == 200) {
        return Commande.fromJson(response.data);
      } else {
        throw Exception('Failed to update commande');
      }
    } catch (e) {
      throw Exception('Error updating commande: $e');
    }
  }

  // Delete a commande by ID
  Future<void> deleteCommande(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete commande');
      }
    } catch (e) {
      throw Exception('Error deleting commande: $e');
    }
  }
}
