import 'package:grocery/services/product_service.dart';
import 'package:grocery/services/category_service.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'package:grocery/services/client_service.dart';
import 'package:grocery/models/client.dart';

void main() async {
  const apiUrl = '${ApiConstants.baseUrl}/client/clients';
  final clientService = ClientService(apiUrl: apiUrl);

  try {
    List<Client> clients = await clientService.fetchClients();
    print('Category fetched successfully:\n');
    //print('ID: ${client.id}, Name: ${client.username}');
    for (Client client in clients) {
      print('ID: ${client.id}, Name: ${client.username}}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
