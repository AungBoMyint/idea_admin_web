import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mmlearning_admin/bloc/bloc/category_bloc.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/main.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (bloc is CategoryBloc) {
      final state = transition.nextState as CategoryState;
    }
  }
}
