import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/carts/carts_cubit.dart';
import 'package:my_project/cubits/category/category_cubit.dart';
import 'package:my_project/cubits/products/product_cubit.dart';
import 'package:my_project/screens/category_page.dart';
import 'package:my_project/screens/product_page.dart';
import '../screens/location_page.dart';
import '../screens/show_categories_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/location':
        return MaterialPageRoute(
            builder: (context) => const SelectLocation(), settings: settings);
      case '/home':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => CartsCubit()),
                ], child: const HomePage()),
            settings: settings);
      case '/product':
        return MaterialPageRoute(
            builder: (context) => const ProductPage(), settings: settings);
      case '/categories':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => CategoryCubit(),
              child:  const ShowCategories()),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Error')),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Page not found!'),
        ),
      );
    });
  }
}
