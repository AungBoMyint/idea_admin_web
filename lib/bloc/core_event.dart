part of "core_bloc.dart";

class CoreEvent {}

class ChangePageEvent extends CoreEvent {
  final int page;
  ChangePageEvent({required this.page});
}

class ChangeDetailPageEvent extends CoreEvent {
  final DetailPage detailPage;
  ChangeDetailPageEvent({required this.detailPage});
}
