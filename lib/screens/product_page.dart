import 'package:flutter/material.dart';
import 'package:my_project/models/cart_list/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? _product;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      _product = ModalRoute.of(context)?.settings.arguments as Product;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed('/home'),
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          FloatingActionButton(onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            elevation: 0,
            child: const Icon(Icons.thumb_up),
          ),
          const SizedBox(width:10,),
          FloatingActionButton(onPressed: () {},
          shape: const CircleBorder(),
            backgroundColor: Colors.white,
            elevation: 0,
          child: const Icon(Icons.cloud_upload),),
          const SizedBox(width: 10,)
        ],
      ),
    );
  }
}
