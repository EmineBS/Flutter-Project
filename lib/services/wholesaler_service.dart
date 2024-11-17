import 'package:dio/dio.dart';
import '../models/wholesaler.dart';

class WholesalerService {
  final Dio _dio = Dio();
  final String apiUrl;

  WholesalerService({required this.apiUrl});

  // Fetch all wholesalers
  Future<List<Wholesaler>> fetchWholesalers() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"];
        return data.map((item) => Wholesaler.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load wholesalers');
      }
    } catch (e) {
      throw Exception('Error fetching wholesalers: $e');
    }
  }

  // Get wholesaler by ID
  Future<Wholesaler> fetchWholesalerById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return Wholesaler.fromJson(response.data["data"]);
      } else {
        throw Exception('Failed to load wholesaler');
      }
    } catch (e) {
      throw Exception('Error fetching wholesaler: $e');
    }
  }

  // Create a new wholesaler
  Future<Wholesaler> createWholesaler(Wholesaler wholesaler) async {
    try {
      Response response = await _dio.post(apiUrl, data: wholesaler.toJson());

      if (response.statusCode == 201) {
        return Wholesaler.fromJson(response.data);
      } else {
        throw Exception('Failed to create wholesaler');
      }
    } catch (e) {
      throw Exception('Error creating wholesaler: $e');
    }
  }

  // Update a wholesaler by ID
  Future<Wholesaler> updateWholesaler(int id, Wholesaler wholesaler) async {
    try {
      Response response =
          await _dio.put('$apiUrl/$id', data: wholesaler.toJson());

      if (response.statusCode == 200) {
        return Wholesaler.fromJson(response.data);
      } else {
        throw Exception('Failed to update wholesaler');
      }
    } catch (e) {
      throw Exception('Error updating wholesaler: $e');
    }
  }

  // Delete a wholesaler by ID
  Future<void> deleteWholesaler(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete wholesaler');
      }
    } catch (e) {
      throw Exception('Error deleting wholesaler: $e');
    }
  }
}
