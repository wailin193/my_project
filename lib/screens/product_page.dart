import 'package:flutter/material.dart';
import 'package:my_project/models/cart_list/product.dart';
import 'package:my_project/models/product_list/product_list.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductList? _product;

  double? totalPrice = 0.0;
  double? realDiscountedValue = 0.0;
  double? discountedTotalValue = 0.0;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      _product = ModalRoute.of(context)?.settings.arguments as ProductList;
    }
    totalPrice = (_product?.price ?? 0) * (_product?.minimumOrderQuantity ?? 0);
    // print(totalPrice);
    realDiscountedValue = (totalPrice ?? 0) * ((_product?.discountPercentage ?? 0) / 100);
    // print(realDiscountedValue);
    discountedTotalValue = (totalPrice ?? 0) - (realDiscountedValue ?? 0);
    // print(discountedTotalValue);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Material(
          elevation: 0,
          shape: const CircleBorder(),
          color: Colors.white,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        actions: [
          FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            elevation: 0,
            heroTag: null,
            child: const Icon(Icons.thumb_up),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            elevation: 0,
            heroTag: null,
            child: const Icon(Icons.cloud_upload),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        title: Text(_product?.title ?? ''),
      ),
      body: Column(
        children: [
          Image.network(
            _product?.thumbnail ?? '',
            height: 300,
            width: double.infinity,
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _product?.title ?? '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.cyanAccent,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('4.8'),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '117 reviews',
                                  style: TextStyle(fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.discount,
                                  color: Colors.cyanAccent,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(('${_product?.discountPercentage} %')
                                    .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Price ',
                                ),
                                Text(
                                  ('€ ${_product?.price}').toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Quantity ',
                                ),
                                Text(
                                  ('${_product?.minimumOrderQuantity}').toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total ',
                                ),
                                Text(
                                  ('€ ${totalPrice?.toStringAsFixed(2)}').toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Discounted Total ',
                                ),
                                Text(
                                  ('€ ${discountedTotalValue?.toStringAsFixed(2)}')
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[400],
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 150),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.black),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
