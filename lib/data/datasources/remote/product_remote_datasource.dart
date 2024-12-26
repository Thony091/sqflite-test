import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';

// abstract class ProductRemoteDataSource {
//   Future<List<ProductModel>> fetchProducts();
// }

// class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
//   final http.Client client;

//   ProductRemoteDataSourceImpl(this.client);

//   @override
//   Future<List<ProductModel>> fetchProducts() async {
//     final response = await client.get(Uri.parse('https://api.example.com/products'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body) as List;
//       return data.map((json) => ProductModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }
// }

// import '../../models/product_model.dart';
import 'mock_data.dart'; // Importamos los datos simulados

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> fetchProducts() async {
    // Simular retraso para imitar una solicitud HTTP
    await Future.delayed(const Duration(seconds: 1));

    // Convertir los datos simulados en una lista de ProductModel
    return mockProducts.map((json) => ProductModel.fromJson(json)).toList();
  }
}
