// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discount_bloc.dart';

enum DiscountStatus {
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
  initial,
  loading,
}

class DiscountState extends Equatable {
  final Discount? selectedDiscount;

  //form-data
  final DiscountStatus discountStatus;
  final RequestStatus status;
  final FormzSubmissionStatus formStatus;
  final FormImage formImage;
  final FormStringRequired formTitle;
  final FormDoubleRequired formPercentage;
  final FormIdList formDiscountItems;
  //
  final bool hasMore;
  final String? next;
  final List<Discount>? discounts;
  final String? error;
  final bool isValid;
  const DiscountState({
    this.discountStatus = DiscountStatus.initial,
    this.discounts,
    this.hasMore = false,
    this.isValid = false,
    this.next,
    this.error,
    this.status = RequestStatus.initial,
    this.selectedDiscount,
    this.formDiscountItems = const FormIdList.pure(),
    this.formImage = const FormImage.pure(),
    this.formPercentage = const FormDoubleRequired.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.formTitle = const FormStringRequired.pure(),
  });

  @override
  List<Object?> get props => [
        discountStatus,
        discounts,
        hasMore,
        isValid,
        next,
        error,
        status,
        selectedDiscount,
        formDiscountItems,
        formImage,
        formPercentage,
        formStatus,
        formTitle,
      ];

  DiscountState copyWith({
    bool clearSelectedDiscount = false,
    Discount? selectedDiscount,
    DiscountStatus? discountStatus,
    RequestStatus? status,
    FormzSubmissionStatus? formStatus,
    FormImage? formImage,
    FormStringRequired? formTitle,
    FormDoubleRequired? formPercentage,
    FormIdList? formDiscountItems,
    bool? hasMore,
    String? next,
    List<Discount>? discounts,
    String? error,
    bool? isValid,
  }) {
    return DiscountState(
      selectedDiscount: clearSelectedDiscount
          ? null
          : selectedDiscount ?? this.selectedDiscount,
      discountStatus: discountStatus ?? this.discountStatus,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      formImage: formImage ?? this.formImage,
      formTitle: formTitle ?? this.formTitle,
      formPercentage: formPercentage ?? this.formPercentage,
      formDiscountItems: formDiscountItems ?? this.formDiscountItems,
      hasMore: hasMore ?? this.hasMore,
      next: next ?? this.next,
      discounts: discounts ?? this.discounts,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
    );
  }
}
