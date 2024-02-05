import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/model/category.dart';

import '../../../constant.dart';
import '../../../model/category_list_response.dart';
import '../../../model/response_error.dart';

class CategoryRepositoryApi {
  final box = Hive.box<String>(userDatabase);
  final _dio = Dio();
  //Need to get token from HiveLocalDatabase and put it in
  //the headers

  Future<Category?> postCategory(Map<String, dynamic> data) async {
    Completer<Category?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.post(categoryPath,
          data: FormData.fromMap(data),
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (response.statusCode == 201) {
        completer.complete(Category.fromJson(response.data));
      }
    } catch (e) {
      completer.complete(null);
    }
    return completer.future;
  }

  Future<Category?> updateCategory(
      {required Map<String, dynamic> data, required int categoryID}) async {
    Completer<Category?> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.patch(
        "$categoryPath$categoryID/",
        data: FormData.fromMap(data),
        options: Options(headers: {
          "Authorization": "JWT $key",
        }),
      );
      if (response.statusCode == 200) {
        completer.complete(Category.fromJson(response.data));
      }
    } on DioException catch (e) {
      completer.complete(null);
      log("********Error: ${e.message}");
    }
    return completer.future;
  }

  Future<bool> deleteCategory(int categoryID) async {
    Completer<bool> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.delete("$categoryPath$categoryID/",
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

  Future<CategoryListResponse> searchCategory(
      {required String path, required String data}) async {
    Completer<CategoryListResponse> completer = Completer();
    try {
      final response = await _dio.get(path, queryParameters: {
        "search": data,
      });
      if (response.statusCode == 200) {
        completer.complete(CategoryListResponse.fromJson(response.data));
      } else {
        completer.complete(
            CategoryListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        CategoryListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }

  Future<CategoryListResponse> getCategory(String path) async {
    Completer<CategoryListResponse> completer = Completer();
    try {
      final response = await _dio.get(
        path,
      );
      if (response.statusCode == 200) {
        completer.complete(CategoryListResponse.fromJson(response.data));
      } else {
        completer.complete(
            CategoryListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        CategoryListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }
}
