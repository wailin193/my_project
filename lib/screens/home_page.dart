import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/category/category_cubit.dart';
import 'package:my_project/cubits/products/product_cubit.dart';
import 'package:my_project/models/product_list/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic>? _location;

  @override
  void initState() {
    // context.read<CartsCubit>().fetchData();
    context.read<CategoryCubit>().fetchCategory();
    context.read<ProductCubit>().fetchProduct();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _location =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
                // color: Colors.grey
                boxShadow: [
                  BoxShadow(
                    color: Colors.white, // Shadow color
                    spreadRadius: 3, // Blur radius
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Selected Location : ${_location?['location']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SearchBar(
                    hintText: 'Search The Entire Shop',
                    leading: Icon(Icons.search),
                    backgroundColor: MaterialStatePropertyAll(Colors.white70),
                    // overlayColor: MaterialStatePropertyAll(Colors.red),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.white70),
                    shadowColor: MaterialStatePropertyAll(Colors.white70),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      // height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey)),
                      child: const Text(
                        "Delivery is 50% cheaper",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      // color: Colors.grey
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white, // Shadow color
                          spreadRadius: 3, // Blur radius
                          offset: Offset(0, 3), // Changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Categories",
                              style: TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamed('/categories'),
                              child: const Row(
                                children: [
                                  Text(
                                    "See More",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    grade: 0.5,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is CategorySuccess) {
                              return Container(
                                height: 80,
                                decoration: const BoxDecoration(
                                  // boxShadow: ,
                                  color: Colors.white,
                                ),
                                child: GridView.builder(
                                  itemCount: state.categoryList.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(15),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1/3,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Material(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(25),
                                      child: Center(
                                        child: Text(
                                          state.categoryList[index] ?? '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              );
                            } else if (state is CategoryFail) {
                              return const Center(child: Text("Error"));
                            } else {
                              return const Center(child: Text("Unknown State"));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Products',
                              style: TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed('/productList'),
                              child: const Row(
                                children: [
                                  Text(
                                    "See More",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_rounded,
                                    grade: 0.5,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is ProductSuccess) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 6,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: 6 / 7,
                                  ),
                                  itemBuilder: (context, index) {
                                    ProductList? product = state.productMain.products![index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            '/product',
                                            arguments: product);
                                      },
                                      child: Material(
                                        borderRadius: BorderRadius.circular(20),
                                        elevation: 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              state.productMain.products?[index].thumbnail ??
                                                  "",
                                              height: 100,
                                              width: 200,
                                            ),
                                            Text(
                                              state.productMain.products?[index].title ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '€ ${state.productMain.products?[index].price.toString()}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                    ));
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
