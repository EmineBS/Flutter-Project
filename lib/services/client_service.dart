import 'package:dio/dio.dart';
import '../models/client.dart';

class ClientService {
  final Dio _dio = Dio();
  final String apiUrl;

  ClientService({required this.apiUrl});

  // Fetch all clients
  Future<List<Client>> fetchClients() async {
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Client.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      throw Exception('Error fetching clients: $e');
    }
  }

  // Get client by ID
  Future<Client> fetchClientById(int id) async {
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        return Client.fromJson(response.data);
      } else {
        throw Exception('Failed to load client');
      }
    } catch (e) {
      throw Exception('Error fetching client: $e');
    }
  }

  // Create a new client
  Future<Client> createClient(Client client) async {
    try {
      Response response = await _dio.post(apiUrl, data: client.toJson());

      if (response.statusCode == 201) {
        return Client.fromJson(response.data);
      } else {
        throw Exception('Failed to create client');
      }
    } catch (e) {
      throw Exception('Error creating client: $e');
    }
  }

  // Update a client by ID
  Future<Client> updateClient(int id, Client client) async {
    try {
      Response response = await _dio.put('$apiUrl/$id', data: client.toJson());

      if (response.statusCode == 200) {
        return Client.fromJson(response.data);
      } else {
        throw Exception('Failed to update client');
      }
    } catch (e) {
      throw Exception('Error updating client: $e');
    }
  }

  // Delete a client by ID
  Future<void> deleteClient(int id) async {
    try {
      Response response = await _dio.delete('$apiUrl/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete client');
      }
    } catch (e) {
      throw Exception('Error deleting client: $e');
    }
  }
}
