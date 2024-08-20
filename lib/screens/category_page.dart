import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/carts/carts_cubit.dart';

import '../models/cart_list/product.dart';

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
    context.read<CartsCubit>().fetchData();
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
                            Row(
                              children: [
                                const Text(
                                  "See More",
                                  style: TextStyle(fontSize: 10),
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.arrow_circle_right_rounded,
                                    grade: 0.5,
                                  ),
                                  onTap: () => Navigator.of(context).pushNamed('/categories'),
                                )
                              ],
                            ),
                          ],
                        ),
                        BlocBuilder<CartsCubit, CartsState>(
                          builder: (context, state) {
                            if (state is CartsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is CartsSuccess) {
                              return Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                  // boxShadow: ,
                                  color: Colors.white,
                                ),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Material(
                                        // borderRadius: BorderRadius.circular(100),
                                        // elevation: 5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    state
                                                            .cartList
                                                            .carts?[index]
                                                            .products?[1]
                                                            .thumbnail ??
                                                        "",
                                                  ),
                                                  fit: BoxFit
                                                      .cover, // Ensures the image covers the entire circle
                                                ),
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              width: 80,
                                              height: 40,
                                              child: Text(
                                                state.cartList.carts?[index]
                                                        .products?[1].title ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
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
                              return const Center(child: Text("Error"));
                            } else {
                              return const Center(child: Text("Unknown State"));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<CartsCubit, CartsState>(
              builder: (context, state) {
                if (state is CartsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartsSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.cartList.carts?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
