import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_project/logics/category_api.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryApi _categoryApi = CategoryApi();
  List<String> category = [];

  CategoryCubit() : super(CategoryInitial());

  Future<void> fetchCategory() async {
    emit(CategoryLoading());

    try {
      category = await _categoryApi.fetchCategory();
      if (category != null) {
        emit(CategorySuccess(category));
      } else {
        emit(CategoryFail('Error'));
      }
    } catch (e) {
      emit(CategoryFail(e.toString()));
    }
  }
}
