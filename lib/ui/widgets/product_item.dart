import 'package:crud_app/ui/screens/delete_product_screen.dart';
import 'package:crud_app/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  Widget customText({required String text}) {
    return Text(
      text,
      style: GoogleFonts.poppins(color: const Color(0xFF240F4F,),fontSize: 13,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Card(
        child: ListTile(
          leading: SizedBox(
            height: 55,
            width: 55,
            child: Image.network(product.image ?? 'Image file format error!'),
          ),
          title: Text(
            product.productName ?? '',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(text: 'Product Code: \n${product.productCode ?? ''}'),
              customText(text: 'Quantity: ${product.quantity ?? ''}'),
              customText(text: 'Unit Price: ${product.unitPrice ?? ''}',),
              customText(text: 'Total Price: ${product.totalPrice ?? ''}'),
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
