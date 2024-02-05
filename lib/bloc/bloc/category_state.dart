// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

enum CategoryStatus {
  adding,
  deleting,
  updating,
  searching,
  addingSuccess,
  updatingSuccess,
  deletingSuccess,
  searchingSuccess,
  updatingFail,
  deletingFail,
  addingFail,
  searchingFail,
  initial
}

class CategoryState extends Equatable {
  final CategoryStatus categoryStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final bool hasMore;
  final String? next;
  final List<Category>? categories;
  final String? error;
  final FormTitle formTitle;
  final FormImage formImage;
  final bool isValid;
  final Category? selectedCategory;
  const CategoryState({
    this.selectedCategory,
    this.isValid = false,
    this.formTitle = const FormTitle.pure(),
    this.formImage = const FormImage.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.categoryStatus = CategoryStatus.initial,
    this.status = RequestStatus.initial,
    this.hasMore = false,
    this.next,
    this.categories,
    this.error,
  });

  @override
  List<Object?> get props => [
        categories,
        categoryStatus,
        status,
        hasMore,
        next,
        error,
        formImage,
        formTitle,
        formStatus,
        isValid,
        selectedCategory,
      ];

  CategoryState copyWith({
    CategoryStatus? categoryStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    bool? hasMore,
    String? next,
    List<Category>? categories,
    String? error,
    FormTitle? formTitle,
    FormImage? formImage,
    bool? isValid,
    Category? selectedCategory,
    bool clearSelectedCategory = false,
  }) {
    return CategoryState(
      selectedCategory: clearSelectedCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
      isValid: isValid ?? this.isValid,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      categories: categories ?? this.categories,
      error: error ?? this.error,
      formTitle: formTitle ?? this.formTitle,
      formImage: formImage ?? this.formImage,
    );
  }
}
