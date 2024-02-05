// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "core_bloc.dart";

enum DetailPage {
  courseAdd,
  categoryAdd,
  categoryDetail,
  sliderAdd,
  discountAdd,
  studentAdd,
  enrollmentAdd,
  ratingAdd,
  reviewAdd,
  empty
}

class CoreState extends Equatable {
  const CoreState({
    this.page = 0,
    this.detailPage = DetailPage.empty,
  });
  final int page;
  final DetailPage detailPage;

  @override
  List<Object?> get props => [page, detailPage];

  CoreState copyWith({
    int? page,
    DetailPage? detailPage,
  }) {
    return CoreState(
      page: page ?? this.page,
      detailPage: detailPage ?? this.detailPage,
    );
  }
}
