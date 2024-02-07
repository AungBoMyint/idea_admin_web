import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mmlearning_admin/app_theme.dart';
import 'package:mmlearning_admin/bloc/bloc/auth_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/category_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/course_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/discount_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/enrollment_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/rating_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/review_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/signin_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/slider_bloc.dart';
import 'package:mmlearning_admin/bloc/bloc/student_bloc.dart';
import 'package:mmlearning_admin/bloc/core_bloc.dart';
import 'package:mmlearning_admin/core/data/common_repository.dart';
import 'package:mmlearning_admin/home/presentation/course/course_repository.dart';
import '/home/presentation/category/category_repository.dart';
import '/home/presentation/core_page.dart';
import '/home/presentation/slider/slider_repository.dart';
import '/home/presentation/student/auth_repository.dart';

import 'constant.dart';

final GlobalKey<NavigatorState> materialKey = GlobalKey();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>(userDatabase);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late AuthenticationRepositoryApi authRepo;
  late CategoryRepositoryApi categoryRepo;
  late SliderRepositoryApi sliderRepo;
  late CourseRepositoryApi courseRepo;
  late CommonRepositoryApi comRepo;
  @override
  void initState() {
    authRepo = AuthenticationRepositoryApi();
    categoryRepo = CategoryRepositoryApi();
    sliderRepo = SliderRepositoryApi();
    courseRepo = CourseRepositoryApi();
    comRepo = CommonRepositoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoreBloc>(
          create: (_) => CoreBloc(),
        ),
        BlocProvider<CourseBloc>(
          create: (_) => CourseBloc(courseRepo)..add(GetStartCourseEvent()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepo),
        ),
        BlocProvider<SigninBloc>(
          create: (_) => SigninBloc(authRepo),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) =>
              CategoryBloc(categoryRepo)..add(CategoryStartGetEvent()),
        ),
        BlocProvider<SliderBloc>(
          create: (_) =>
              SliderBloc(sliderRepo, comRepo)..add(SliderStartGetEvent()),
        ),
        BlocProvider<DiscountBloc>(
          create: (_) => DiscountBloc(comRepo)..add(GetStartDiscount()),
        ),
        BlocProvider<StudentBloc>(
          create: (_) => StudentBloc(comRepo)..add(GetStartStudent()),
        ),
        BlocProvider<EnrollmentBloc>(
          create: (_) => EnrollmentBloc(comRepo)..add(GetStartEnrollment()),
        ),
        BlocProvider<RatingBloc>(
          create: (_) => RatingBloc(comRepo)..add(GetStartRating()),
        ),
        BlocProvider<ReviewBloc>(
          create: (_) => ReviewBloc(comRepo)..add(GetStartReview()),
        ),
      ],
      child: MaterialApp(
        key: materialKey,
        title: 'IDEA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        home: const CorePage(),
      ),
    );
  }
}
