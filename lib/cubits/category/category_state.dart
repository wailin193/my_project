part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class CategorySuccess extends CategoryState {
  CategoryApi categoryApi = CategoryApi();
  List<String> categoryList = [];

  CategorySuccess(this.categoryList);
}
class CategoryFail extends CategoryState {
   final String error;

  CategoryFail(this.error);
}
