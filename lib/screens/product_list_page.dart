import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/carts/carts_cubit.dart';
import 'package:my_project/models/cart_list/product.dart';

class ProuctListPage extends StatefulWidget {
  const ProuctListPage({super.key});

  @override
  State<ProuctListPage> createState() => _ProuctListPageState();
}

class _ProuctListPageState extends State<ProuctListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartsCubit>().fetchData();
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
            BlocBuilder<CartsCubit, CartsState>(
              builder: (context, state) {
                if (state is CartsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartsSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.cartList.carts?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 6 / 7,
                      ),
                      itemBuilder: (context, index) {
                        Product product =
                            state.cartList.carts![index].products![1];
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
                                  state.cartList.carts?[index].products?[1]
                                          .thumbnail ??
                                      "",
                                  height: 100,
                                  width: 200,
                                ),
                                Text(
                                  state.cartList.carts?[index].products?[1]
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
                                  '€ ${state.cartList.carts?[index].products?[1].price}',
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
                } else if (state is CartsFail) {
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
