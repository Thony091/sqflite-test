import '../repositories/product_repository.dart';

class SyncProducts {
  final ProductRepository repository;

  SyncProducts(this.repository);

  Future<void> call() async {
    // Lógica para sincronizar productos pendientes
    // Esto puede incluir recuperar datos locales y enviarlos al servidor.
  }
}
