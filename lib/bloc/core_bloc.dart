import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'core_state.dart';
part 'core_event.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  CoreBloc() : super(const CoreState()) {
    on<ChangePageEvent>(_onChangePage);
    on<ChangeDetailPageEvent>(_onChangeDetailPage);
  }

  FutureOr<void> _onChangePage(ChangePageEvent event, Emitter<CoreState> emit) {
    emit(state.copyWith(page: event.page, detailPage: DetailPage.empty));
  }

  FutureOr<void> _onChangeDetailPage(
      ChangeDetailPageEvent event, Emitter<CoreState> emit) {
    emit(state.copyWith(detailPage: event.detailPage));
  }
}
