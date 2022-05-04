import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final List<Categories> categories;
  CategoriesCubit(this.categories) : super(CategoriesInitial()) {
    emit(AllCategoriesState(categories: categories));
  }

  void categoriesUpdated(List<Categories> cats) {
    emit(AllCategoriesState(categories: cats));
  }

  void addCategoryListUpdated(Box<Categories> box, Categories category) {
    DbFunctions.addCategory(category);
    emit(AllCategoriesState(categories: box.values.toList()));
  }

  void editCategoryListUpdated(
      Box<Categories> box, Categories category, int key) {
    DbFunctions.updateCategory(key, category);
    emit(AllCategoriesState(categories: box.values.toList()));
  }

  void deleteCategoryListUpdated(Box<Categories> box, int key) {
    DbFunctions.deleteCategory(key);
    emit(AllCategoriesState(categories: box.values.toList()));
  }

  Categories dropDownValue(Categories? categories) {
    emit(DropDownState(categories: categories));
    return categories!;
  }

  DateTime dateTimeTake(DateTime date) {
    emit(DatePic(dateTime: date));
    return date;
  }
}
