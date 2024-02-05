import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/function.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course_list_response.dart';

import '../../../constant.dart';
import '../../../model/category_list_response.dart';
import '../../../model/course.dart';
import '../../../model/response_error.dart';
import '../../model/discount_list_response.dart';
import '../../model/student_list_response.dart';

class CommonRepositoryApi {
  final box = Hive.box<String>(userDatabase);
  final _dio = Dio();
  //Need to get token from HiveLocalDatabase and put it in
  //the headers
  Future<StudentListResponse> getStudent(String path) async {
    Completer<StudentListResponse> completer = Completer();
    try {
      final response = await _dio.get(
        path,
      );
      if (response.statusCode == 200) {
        completer.complete(StudentListResponse.fromJson(response.data));
      } else {
        completer.complete(
            StudentListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        StudentListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }

  Future<DiscountListResponse> getDiscount(String path) async {
    Completer<DiscountListResponse> completer = Completer();
    try {
      final response = await _dio.get(
        path,
      );
      if (response.statusCode == 200) {
        completer.complete(DiscountListResponse.fromJson(response.data));
      } else {
        completer.complete(
            DiscountListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        DiscountListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }

  Future<Map<String, dynamic>?> postData({
    required Map<String, dynamic> data,
    required String path,
    //required void Function(double v) uploading,
  }) async {
    Completer<Map<String, dynamic>?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(headers: {
          "Authorization": "JWT $key",
        }),
        //onSendProgress: (count, total) => uploading(count / total),
      );
      if (response.statusCode == 201) {
        completer.complete(response.data);
      } else {
        completer.complete(null);
      }
    } catch (e) {
      completer.complete(null);
    }
    return completer.future;
  }

  Future<Map<String, dynamic>?> updateData({
    required Map<String, dynamic> data,
    required String path,
    //required void Function(double v) uploading,
  }) async {
    Completer<Map<String, dynamic>?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: Options(headers: {
          "Authorization": "JWT $key",
        }),
        //onSendProgress: (count, total) => uploading(count / total),
      );
      if (response.statusCode == 200) {
        completer.complete(response.data);
      } else {
        completer.complete(null);
      }
    } catch (e) {
      completer.complete(null);
    }
    return completer.future;
  }

  Future<Map<String, dynamic>?> postFormData({
    required Map<String, dynamic> data,
    required void Function(double v) uploading,
    required String path,
  }) async {
    Completer<Map<String, dynamic>?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.post(
        path,
        data: FormData.fromMap(data),
        options: Options(headers: {
          "Authorization": "JWT $key",
        }),
        onSendProgress: (count, total) => uploading(count / total),
      );
      if (response.statusCode == 201) {
        completer.complete(response.data);
      } else {
        completer.complete(null);
      }
    } catch (e) {
      completer.complete(null);
    }
    return completer.future;
  }

  Future<Map<String, dynamic>?> updateFormData({
    required Map<String, dynamic> data,
    required void Function(double v) uploading,
    required String path,
  }) async {
    Completer<Map<String, dynamic>?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.patch(
        path,
        data: FormData.fromMap(data),
        options: Options(headers: {
          "Authorization": "JWT $key",
        }),
        onSendProgress: (count, total) => uploading(count / total),
      );
      if (response.statusCode == 200) {
        completer.complete(response.data);
      } else {
        completer.complete(null);
      }
    } catch (e) {
      completer.complete(null);
    }
    return completer.future;
  }

  Future<bool> delete(String path) async {
    Completer<bool> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.delete(path,
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (response.statusCode == 204) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }
}
