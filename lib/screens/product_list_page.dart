import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/carts/carts_cubit.dart';
import 'package:my_project/cubits/products/product_cubit.dart';

import '../models/product_list/product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Products List")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.productMain.products?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 6 / 7,
                      ),
                      itemBuilder: (context, index) {
                        ProductList? product =
                            state.productMain.products?[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/product', arguments: product);
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  state.productMain.products?[index]
                                          .thumbnail ??
                                      "",
                                  height: 100,
                                  width: 200,
                                ),
                                Text(
                                  state.productMain.products?[index]
                                          .title ??
                                      "",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '€ ${state.productMain.products?[index].price}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ProductFail) {
                  return Center(child: Text(state.error));
                } else {
                  return const Center(child: Text("Unknown State"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
