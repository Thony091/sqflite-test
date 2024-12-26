import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({
    super.key, 
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      leading: CircleAvatar(
        child: Text(product.name[0].toUpperCase()),
      ),
    );
  }
}
