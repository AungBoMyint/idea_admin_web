import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/home/presentation/category/category_repository.dart';
import 'package:mmlearning_admin/main.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/form_image.dart';
import 'package:mmlearning_admin/model/title.dart';

import '../../api_path.dart';
import '../../enum_class.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepositoryApi cateRepo;
  CategoryBloc(this.cateRepo) : super(const CategoryState()) {
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<CategoryStartGetEvent>(_onStartGet);
    on<CategoryGetMoreEvent>(_onGetMore);
    on<TitleChangeEvent>(_onTitleChange);
    on<ImageChangeEvent>(_onImageChange);
    on<SetSelectedCategory>(_onSetSelectedCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<SearchCategoryEvent>(_onSearchCategory);
  }

  FutureOr<void> _onStartGet(
      CategoryStartGetEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await cateRepo.getCategory(categoryPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        categories: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMore(
      CategoryGetMoreEvent event, Emitter<CategoryState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await cateRepo.getCategory(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Category> previousList = List.from(state.categories!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          categories: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onAddCategory(
      AddCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          categoryStatus: CategoryStatus.adding));
      Category? response = await cateRepo.postCategory({
        "title": state.formTitle.value,
        "image": MultipartFile.fromBytes(
            Uint8List.fromList(state.formImage.value),
            filename: "${DateTime.now().toIso8601String()}.png"),
      });

      if (response == null) {
        //fail
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            categoryStatus: CategoryStatus.addingFail));
      } else {
        emit(state.copyWith(
            formStatus: FormzSubmissionStatus.success,
            categoryStatus: CategoryStatus.addingSuccess));
        add(CategoryStartGetEvent());
      }
    }
  }

  FutureOr<void> _onTitleChange(
      TitleChangeEvent event, Emitter<CategoryState> emit) {
    final title = FormTitle.dirty(value: event.title);
    emit(state.copyWith(
        formTitle: title, isValid: Formz.validate([title, state.formImage])));
  }

  FutureOr<void> _onImageChange(
      ImageChangeEvent event, Emitter<CategoryState> emit) {
    final image = FormImage.dirty(value: event.image);
    emit(state.copyWith(
        formImage: image, isValid: Formz.validate([image, state.formTitle])));
  }

  FutureOr<void> _onSetSelectedCategory(
      SetSelectedCategory event, Emitter<CategoryState> emit) async {
    if (event.category == null) {
      emit(
        state.copyWith(
          selectedCategory: null,
          clearSelectedCategory: true,
          formImage: const FormImage.pure(),
          formTitle: const FormTitle.pure(),
          isValid: false,
        ),
      );
    } else {
      final response = await http.get(Uri.parse(event.category!.image));
      final formImage = FormImage.dirty(value: response.bodyBytes);
      final formTitle = FormTitle.dirty(value: event.category!.title);
      emit(
        state.copyWith(
            selectedCategory: event.category,
            clearSelectedCategory: false,
            formImage: formImage,
            formTitle: formTitle,
            isValid: Formz.validate([formImage, formTitle])),
      );
    }
  }

  FutureOr<void> _onDeleteCategory(
      DeleteCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.deleting));

    bool response = await cateRepo.deleteCategory(
      event.categoryID,
    );

    if (response) {
      //success
      emit(state.copyWith(
        categoryStatus: CategoryStatus.deletingSuccess,
      ));
      add(CategoryStartGetEvent());
    } else {
      emit(state.copyWith(
        categoryStatus: CategoryStatus.deletingFail,
      ));
    }
  }

  FutureOr<void> _onUpdateCategory(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.isValid && state.formStatus != FormzSubmissionStatus.inProgress) {
      //make uploading
      emit(state.copyWith(
          formStatus: FormzSubmissionStatus.inProgress,
          categoryStatus: CategoryStatus.updating));
      Category? response = await cateRepo.updateCategory(
        data: {
          "title": state.formTitle.value,
          "image": MultipartFile.fromBytes(state.formImage.value,
              filename: "${DateTime.now().toIso8601String()}.png")
        },
        categoryID: state.selectedCategory!.id,
      );

      if (response == null) {
        //fail
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.failure,
          categoryStatus: CategoryStatus.updatingFail,
        ));
      } else {
        emit(state.copyWith(
          formStatus: FormzSubmissionStatus.success,
          categoryStatus: CategoryStatus.updatingSuccess,
        ));
        add(CategoryStartGetEvent());
      }
    }
  }

  FutureOr<void> _onSearchCategory(
      SearchCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.categoryStatus != CategoryStatus.searching) {
      //search
      final response =
          await cateRepo.searchCategory(path: categoryPath, data: event.data);
      if (response.error == null) {
        //success
        emit(state.copyWith(
          categoryStatus: CategoryStatus.searchingSuccess,
          hasMore: response.next == null ? false : true,
          next: response.next,
          categories: response.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          categoryStatus: CategoryStatus.searchingFail,
          error: response.error?.detail,
        ));
      }
    }
  }
}
