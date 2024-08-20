import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/cubits/category/category_cubit.dart';

class ShowCategories extends StatefulWidget {
  const ShowCategories({super.key});

  @override
  State<ShowCategories> createState() => _ShowCategoriesState();
}

class _ShowCategoriesState extends State<ShowCategories> {
  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategory();
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
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategorySuccess) {
            print(state.categoryList);
            return GridView.builder(
              itemCount: state.categoryList.length,
              padding: EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 10/2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                    child: Text(
                      state.categoryList[index] ?? '',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          } else if (state is CategoryFail) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}
