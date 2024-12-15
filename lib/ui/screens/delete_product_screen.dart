import 'dart:convert';

import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class DeleteProductScreen extends StatefulWidget {
  const DeleteProductScreen({super.key, required this.product});

  static const String name = '/delete-product';

  final Product product;

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _deleteProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
  }

  Widget customText({required String text}) {
    return Text(
      text,
      style: GoogleFonts.poppins(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildProductForm(),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: Image.network(_imageTEController.text),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      customText(
                          text: 'Product Name: ${_nameTEController.text}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      customText(
                          text: 'Product Code: ${_codeTEController.text}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      customText(
                          text:
                              'Product Quantity: ${_quantityTEController.text}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      customText(
                          text: 'Product Price: ${_priceTEController.text}'),
                      const SizedBox(
                        height: 5.0,
                      ),
                      customText(
                          text:
                              'Product Total Price: ${_totalPriceTEController.text}'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: _deleteProductInProgress == false,
                    replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProduct();
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete Product'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _deleteProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      Map<String, dynamic> requestBode = {
        "ProductName": _nameTEController.text.trim(),
        "ProductCode": _codeTEController.text.trim(),
        "Img": _imageTEController.text.trim(),
        "UnitPrice": _priceTEController.text.trim(),
        "Qty": _quantityTEController.text.trim(),
        "TotalPrice": _totalPriceTEController.text.trim(),
      };
    }

    _deleteProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product has been deleted')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product delete failed! Try again')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _quantityTEController.dispose();
    _codeTEController.dispose();
    _imageTEController.dispose();
  }
}
