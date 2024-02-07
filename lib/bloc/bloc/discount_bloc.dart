import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/form/form_double_required.dart';
import 'package:mmlearning_admin/form/form_id_list.dart';
import 'package:mmlearning_admin/form/form_string_required.dart';
import 'package:mmlearning_admin/model/discount.dart';
import 'package:mmlearning_admin/model/form_image.dart';
import 'package:mmlearning_admin/model/title.dart';

import '../../enum_class.dart';
import '../../model/discount_list_response.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  CommonRepositoryApi comRepo;
  DiscountBloc(this.comRepo) : super(const DiscountState()) {
    on<ChangeSelectedDiscount>(_onChangeSelectedDiscount);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeImage>(_onChangeImage);
    on<ChangeDiscount>(_onChangeDiscount);
    on<ChangeDiscountItem>(_onChangeDiscountItem);
    on<AddDiscount>(_onAddDiscount);
    on<UpdateDiscount>(_onUpdateDiscount);
    on<DeleteDiscount>(_onDeleteDiscount);
    on<GetStartDiscount>(_onGetStartDiscount);
    on<GetMoreDiscount>(_onGetMoreDiscount);
    on<SearchDiscount>(_onSearchDiscount);
  }

  FutureOr<void> _onChangeSelectedDiscount(
      ChangeSelectedDiscount event, Emitter<DiscountState> emit) async {
    if (event.disocunt == null) {
      //clear data
      emit(
        state.copyWith(
          clearSelectedDiscount: true,
          selectedDiscount: null,
          formDiscountItems: FormIdList.pure(),
          formImage: FormImage.pure(),
          formTitle: FormStringRequired.pure(),
          formPercentage: FormDoubleRequired.pure(),
        ),
      );
    } else {
      emit(state.copyWith(discountStatus: DiscountStatus.loading));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(
        discountStatus: DiscountStatus.initial,
        selectedDiscount: event.disocunt,
        formDiscountItems: FormIdList.dirty(
            value: event.disocunt?.discountItems
                    ?.map((e) => e["course"]["id"] as int)
                    .toList() ??
                []),
        formImage: const FormImage.dirty(value: [1]),
        formTitle: FormStringRequired.dirty(value: event.disocunt?.title ?? ""),
        formPercentage: FormDoubleRequired.dirty(
            value: (event.disocunt?.discountPercentage ?? 0.0) as double),
      ));
    }
  }

  FutureOr<void> _onChangeTitle(
      ChangeTitle event, Emitter<DiscountState> emit) {
    final title = FormStringRequired.dirty(value: event.value);
    emit(state.copyWith(
        formTitle: title,
        isValid: Formz.validate([
          title,
          state.formImage,
          state.formPercentage,
        ])));
  }

  FutureOr<void> _onChangeImage(
      ChangeImage event, Emitter<DiscountState> emit) {
    final image = FormImage.dirty(value: event.value);
    emit(state.copyWith(
        formImage: image,
        isValid: Formz.validate([
          state.formTitle,
          image,
          state.formPercentage,
        ])));
  }

  FutureOr<void> _onChangeDiscount(
      ChangeDiscount event, Emitter<DiscountState> emit) {
    final discount = FormDoubleRequired.dirty(value: event.value);
    emit(state.copyWith(
        formPercentage: discount,
        isValid: Formz.validate([
          state.formTitle,
          state.formImage,
          discount,
        ])));
  }

  FutureOr<void> _onChangeDiscountItem(
      ChangeDiscountItem event, Emitter<DiscountState> emit) {
    if (state.formDiscountItems.value.contains(event.id)) {
      //remove
      List<int> preList = List.from(state.formDiscountItems.value);
      preList.remove(event.id);
      emit(state.copyWith(formDiscountItems: FormIdList.dirty(value: preList)));
    } else {
      //add
      List<int> preList = List.from(state.formDiscountItems.value);
      preList.add(event.id);
      emit(state.copyWith(formDiscountItems: FormIdList.dirty(value: preList)));
    }
  }

  FutureOr<void> _onAddDiscount(
      AddDiscount event, Emitter<DiscountState> emit) async {
    if (state.discountStatus != DiscountStatus.adding && state.isValid) {
      emit(state.copyWith(discountStatus: DiscountStatus.adding));
      final response = await comRepo.postFormData(
        data: {
          "title": state.formTitle.value,
          "image": MultipartFile.fromBytes(
              Uint8List.fromList(state.formImage.value),
              filename: "${DateTime.now().microsecondsSinceEpoch}.png"),
          "discount_percentage": state.formPercentage.value,
        },
        uploading: (v) {
          //Do Nothing
        },
        path: discountPath,
      );
      if (!(response == null)) {
        //if success
        if (state.formDiscountItems.value.isNotEmpty) {
          //if items not null
          for (var courseId in state.formDiscountItems.value) {
            await comRepo.postData(
              data: {
                "course": courseId,
                "discount": response["id"],
              },
              path: discountItemPath,
            );
          }
        }
        //success
        emit(state.copyWith(discountStatus: DiscountStatus.addingSuccess));
        add(GetStartDiscount());
      } else {
        emit(state.copyWith(discountStatus: DiscountStatus.addingFail));
      }
    }
  }

  FutureOr<void> _onGetStartDiscount(
      GetStartDiscount event, Emitter<DiscountState> emit) async {
    emit(state.copyWith(status: RequestStatus.fetching));
    final response = await comRepo.getDiscount(discountPath);
    if (response.error == null) {
      //success
      emit(state.copyWith(
        status: RequestStatus.success,
        hasMore: response.next == null ? false : true,
        next: response.next,
        discounts: response.results,
      ));
    } else {
      //fail
      emit(state.copyWith(
        status: RequestStatus.error,
        error: response.error?.detail,
      ));
    }
  }

  FutureOr<void> _onGetMoreDiscount(
      GetMoreDiscount event, Emitter<DiscountState> emit) async {
    if (state.hasMore) {
      //if has more
      emit(state.copyWith(status: RequestStatus.morefetching));
      final response = await comRepo.getDiscount(state.next!);
      if (response.results?.isNotEmpty == true) {
        List<Discount> previousList = List.from(state.discounts!);
        previousList.addAll(response.results!);
        emit(state.copyWith(
          status: RequestStatus.success,
          discounts: previousList,
          hasMore: response.next == null ? false : true,
          next: response.next,
        ));
      }
    }
  }

  FutureOr<void> _onUpdateDiscount(
      UpdateDiscount event, Emitter<DiscountState> emit) async {
    if (state.discountStatus != DiscountStatus.adding && state.isValid) {
      emit(state.copyWith(discountStatus: DiscountStatus.updating));
      Map<String, dynamic>? response;
      if (state.formImage.value.length == 1) {
        response = await comRepo.updateData(
          data: {
            "title": state.formTitle.value,
            "discount_percentage": state.formPercentage.value,
          },
          path: "$discountPath${state.selectedDiscount!.id}/",
        );
      } else {
        response = await comRepo.updateFormData(
          data: {
            "title": state.formTitle.value,
            "image": MultipartFile.fromBytes(
                Uint8List.fromList(state.formImage.value),
                filename: "${DateTime.now().microsecondsSinceEpoch}.png"),
            "discount_percentage": state.formPercentage.value,
          },
          uploading: (v) {
            //Do Nothing
          },
          path: "$discountPath${state.selectedDiscount!.id}/",
        );
      }
      if (!(response == null)) {
        //if success
        if (state.formDiscountItems.value.isNotEmpty) {
          //if items not null
          for (var map in state.selectedDiscount!.discountItems ?? []) {
            final courseId = map["course"]["id"];
            if (!state.formDiscountItems.value.contains(courseId)) {
              //remove course
              await comRepo.delete(
                "$discountItemPath$courseId/",
              );
            }
          }
          for (var id in state.formDiscountItems.value) {
            List<int> idList = state.selectedDiscount!.discountItems
                    ?.map((e) => e["course"]["id"] as int)
                    .toList() ??
                [];
            if (!idList.contains(id)) {
              //new discount item,so post
              await comRepo.postData(
                data: {
                  "course": id,
                  "discount": response["id"],
                },
                path: discountItemPath,
              );
            }
          }
        }
        //success
        emit(state.copyWith(discountStatus: DiscountStatus.updatingSuccess));
        add(GetStartDiscount());
      } else {
        emit(state.copyWith(discountStatus: DiscountStatus.updatingFail));
      }
    }
  }

  FutureOr<void> _onDeleteDiscount(
      DeleteDiscount event, Emitter<DiscountState> emit) async {
    emit(state.copyWith(discountStatus: DiscountStatus.deleting));
    final response = await comRepo.delete("$discountPath${event.id}/");
    if (response) {
      List<Discount> discounts = List.from(state.discounts ?? []);
      discounts.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(
          discountStatus: DiscountStatus.deletingSuccess,
          discounts: discounts));
    } else {
      emit(state.copyWith(discountStatus: DiscountStatus.deletingFail));
    }
  }

  FutureOr<void> _onSearchDiscount(
      SearchDiscount event, Emitter<DiscountState> emit) async {
    if (state.discountStatus != DiscountStatus.searching) {
      //search
      final response =
          await comRepo.search(path: discountPath, data: event.value);
      if (!(response == null)) {
        final discountResponse = DiscountListResponse.fromJson(response);
        //success
        emit(state.copyWith(
          discountStatus: DiscountStatus.searchingSuccess,
          hasMore: discountResponse.next == null ? false : true,
          next: discountResponse.next,
          discounts: discountResponse.results,
        ));
      } else {
        //fail
        emit(state.copyWith(
          discountStatus: DiscountStatus.searchingFail,
          error: "search discount error!",
        ));
      }
    }
  }
}
