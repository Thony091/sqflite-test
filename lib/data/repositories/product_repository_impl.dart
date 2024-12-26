import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_local_datasource.dart';
import '../datasources/remote/product_remote_datasource.dart';
import '../../core/network/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getProducts() async {
    if (await networkInfo.isConnected) {
      final products = await remoteDataSource.fetchProducts();
      await localDataSource.cacheProducts(products);
      return products;
    } else {
      return localDataSource.getCachedProducts();
    }
  }
}
