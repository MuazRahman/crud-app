import 'package:crud_app/ui/screens/add_new_product_screen.dart';
import 'package:crud_app/ui/screens/delete_product_screen.dart';
import 'package:crud_app/ui/screens/product_list_screens.dart';
import 'package:crud_app/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

class CRUDApp extends StatelessWidget {
  const CRUDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if(settings.name == '/'){
          widget = const ProductListScreens();
        }
        else if(settings.name == AddNewProductScreen.name){
          widget = const AddNewProductScreen();
        }
        else if(settings.name == UpdateProductScreen.name){
          final Product product =  settings.arguments as Product;
          widget = UpdateProductScreen(product: product,);
        }
        else if(settings.name == DeleteProductScreen.name){
          final Product product =  settings.arguments as Product;
          widget = DeleteProductScreen(product: product,);
        }

        return MaterialPageRoute(builder: (context){
          return widget;
        });
      },
    );
  }
}
