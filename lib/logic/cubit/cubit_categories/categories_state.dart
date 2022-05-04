// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState extends Equatable {}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class AllCategoriesState extends CategoriesState {
  final List<Categories> categories;

  AllCategoriesState({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class DropDownState extends CategoriesState {
  final Categories? categories;
  DropDownState({
    required this.categories,
  });

  @override
  List<Object?> get props => [categories];
}

class DatePic extends CategoriesState {
  final DateTime dateTime;
  DatePic({
    required this.dateTime,
  });

  @override
  List<Object?> get props => [dateTime];
}
