part of 'category_bloc.dart';

class CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {}

class CategoryStartGetEvent extends CategoryEvent {}

class CategoryGetMoreEvent extends CategoryEvent {}

class TitleChangeEvent extends CategoryEvent {
  final String title;
  TitleChangeEvent({required this.title});
}

class ImageChangeEvent extends CategoryEvent {
  final List<int> image;
  ImageChangeEvent({required this.image});
}

class SetSelectedCategory extends CategoryEvent {
  final Category? category;
  SetSelectedCategory({this.category});
}

class DeleteCategory extends CategoryEvent {
  final int categoryID;
  DeleteCategory({required this.categoryID});
}

class UpdateCategoryEvent extends CategoryEvent {}

class SearchCategoryEvent extends CategoryEvent {
  final String data;
  SearchCategoryEvent({required this.data});
}
