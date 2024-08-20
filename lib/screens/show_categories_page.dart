import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/products/product_cubit.dart';

class ShowCategories extends StatefulWidget {
  const ShowCategories({super.key});

  @override
  State<ShowCategories> createState() => _ShowCategoriesState();
}

class _ShowCategoriesState extends State<ShowCategories> {

  @override
  void initState() {
    context.read<ProductCubit>().fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.cyan[200],
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            return ListView.builder(
              itemCount: state.productList.products?.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[200]
                        ),
                        child: Center(
                          child: Text(state.productList.products?[index].category ?? '', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[200]
                        ),
                        child: Center(
                          child: Text(state.productList.products?[index].category ?? '', style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }else if (state is ProductFail) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}
