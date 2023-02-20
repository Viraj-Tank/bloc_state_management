import 'package:bloc_state_management/store/models/product.dart';
import 'package:dio/dio.dart';

class StoreRepository {
  final Dio _client = Dio(
    BaseOptions(baseUrl: 'https://fakestoreapi.com/'),
  );

  Future<List<Product>> getProducts() async {
    final response = await _client.get('products');
    final listOfDataInResponse = response.data as List;

    return listOfDataInResponse.map((p) {
      return Product(
        id: p['id'],
        name: p['title'],
        image: p['image'],
      );
    }).toList();
  }
}
