import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio();
  final String apiUrl;

  ProductService({required this.apiUrl});

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
}
