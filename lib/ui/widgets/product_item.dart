import 'package:crud_app/ui/screens/delete_product_screen.dart';
import 'package:crud_app/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Card(
        child: ListTile(
          leading: SizedBox(
            height: 30,
            width: 30,
            child: Image.network(product.image ?? ''),
          ),
          title: Text(product.productName ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Code: ${product.productCode ?? ''}'),
              Text('Quantity: ${product.quantity ?? ''}'),
              Text('Price ${product.unitPrice ?? ''}'),
              Text('Total Price: ${product.totalPrice ?? ''}'),
            ],
          ),
          trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, DeleteProductScreen.name,
                      arguments: product);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.redAccent.shade200),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, UpdateProductScreen.name,
                      arguments: product);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.green.shade500),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
