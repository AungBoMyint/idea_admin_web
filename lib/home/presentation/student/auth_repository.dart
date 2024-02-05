import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../api_path.dart';
import '../../../constant.dart';
import '../../../enum_class.dart';
import '../../../model/student.dart';

class AuthenticationRepositoryApi {
  final StreamController<AuthStatus> _controller =
      StreamController<AuthStatus>();
  final box = Hive.box<String>(userDatabase);
  final _dio = Dio();

  Future<Student?> getUser() async {
    Completer<Student?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.get(profilePath,
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (response.statusCode == 200) {
        completer.complete(Student.fromJson(response.data));
      }
    } on DioException {
      //if 404 means student is not created yet.
      //so we create manually
      final response = await _dio.post(studentsPath,
          data: {"membership": "B"},
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (response.statusCode == 201) {
        completer.complete(Student.fromJson(response.data));
      }
    }
    return completer.future;
  }

  Future<void> logout() async {
    box.delete(jwtKey);
    _controller.add(AuthStatus.unauthenticated);
  }

  Future<SignInStatus> signIn(
      {required String email, required String password}) async {
    Completer<SignInStatus> completer = Completer<SignInStatus>();

    /* try { */
    final response = await _dio.post(
      signInPath,
      data: {"email": email, "password": password},
    );
    if (response.statusCode == 200) {
      final accessKey = response.data["access"];
      box.put(jwtKey, accessKey);
      box.put(jwtBackUpKey, accessKey);
      _controller.add(AuthStatus.authenticated);
      completer.complete(SignInStatus.success);
    } else if (response.statusCode == 401) {
      _controller.add(AuthStatus.unauthenticated);
      completer.complete(SignInStatus.noActiveAccountFound);
    } else {
      _controller.add(AuthStatus.unauthenticated);
      completer.complete(SignInStatus.failed);
    }
    /* } catch (e) {
      log("Error: $e");
      _controller.add(AuthStatus.unauthenticated);
      _completer.complete(SignInStatus.failed);
    } */
    return completer.future;
  }

  Future<void> updateProfile({
    required String avatar,
  }) async {
    final key = box.get(jwtKey, defaultValue: "") as String;
    /* try { */
    final response = await _dio.put(updateProfilePath,
        data: FormData.fromMap({
          "avatar": await MultipartFile.fromFile(avatar),
        }),
        options: Options(headers: {
          "Authorization": "JWT $key",
        }));
    if (response.statusCode == 200) {
      _controller.add(AuthStatus.authenticated);
    }
    /*  } on DioException catch (e) {
      log("Error: $e");
    } */
  }

  //Create User
  Future<bool> createStudent({
    required String userName,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String avatar,
  }) async {
    Completer<bool> completer = Completer<bool>();
    try {
      final response = await _dio.post(
        signUpPath,
        data: {
          "username": userName,
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        },
      );
      if (response.statusCode == 201) {
        //means user created,so we need to create Student
        final studentResponse = await _dio.post(
          adminStudentPath,
          data: FormData.fromMap({
            "avatar": await MultipartFile.fromFile(avatar),
            "user": response.data["id"],
          }),
        );
        if (studentResponse.statusCode == 201) {
          completer.complete(true);
        }
      } else if (response.statusCode == 400) {
        completer.complete(false);
      } else {
        completer.complete(false);
      }
    } on DioException catch (e) {
      log("Error: $e");
      if (e.type == DioExceptionType.badResponse) {
        completer.complete(false);
      } else {
        completer.complete(false);
      }
    }
    return completer.future;
  }

  Future<SignUpStatus> signUp(
      {required String userName,
      required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    Completer<SignUpStatus> completer = Completer<SignUpStatus>();
    try {
      final response = await _dio.post(
        signUpPath,
        data: {
          "username": userName,
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        },
      );
      if (response.statusCode == 201) {
        completer.complete(SignUpStatus.success);
        _controller.add(AuthStatus.signIn);
      } else if (response.statusCode == 400) {
        completer.complete(SignUpStatus.userNameAlreadyExist);
      } else {
        completer.complete(SignUpStatus.failed);
      }
    } on DioException catch (e) {
      log("Error: $e");
      if (e.type == DioExceptionType.badResponse) {
        completer.complete(SignUpStatus.userNameAlreadyExist);
      } else {
        completer.complete(SignUpStatus.failed);
      }
    }
    return completer.future;
  }

  Stream<AuthStatus> get status async* {
    final key = box.get(jwtKey, defaultValue: "") as String;
    if (key.isEmpty) {
      yield AuthStatus.unknown;
    } else {
      yield AuthStatus.authenticated;
    }
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}
