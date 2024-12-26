import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/product_local_datasource.dart';
import '../../data/datasources/remote/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_products.dart';
import '../../core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

// Provider para la fuente de datos local
final localDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  return ProductLocalDataSourceImpl();
});

// Provider para la fuente de datos remota
final remoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl();
  // return ProductRemoteDataSourceImpl(http.Client());
});

// Provider para el estado de la red
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(Connectivity());
});

// Provider para el repositorio
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    localDataSource: ref.watch(localDataSourceProvider),
    remoteDataSource: ref.watch(remoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

// Provider para el caso de uso GetProducts
final getProductsProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.watch(productRepositoryProvider));
});

// Provider para obtener los productos como un FutureProvider
final productProvider = FutureProvider((ref) async {
  final getProducts = ref.watch(getProductsProvider);
  return getProducts();
});
