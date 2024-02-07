import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mmlearning_admin/api_path.dart';
import 'package:mmlearning_admin/home/presentation/slider/slider_list_page.dart';
import 'package:mmlearning_admin/model/blog.dart';
import 'package:mmlearning_admin/slider/model/course_link.dart';
import 'package:mmlearning_admin/slider/model/facebook_link.dart';
import 'package:mmlearning_admin/slider/model/messenger_link.dart';
import 'package:mmlearning_admin/slider/model/slider.dart';
import 'package:mmlearning_admin/slider/model/slider_list_response.dart';
import 'package:mmlearning_admin/slider/model/youtube_link.dart';

import '../../../constant.dart';
import '../../../model/category_list_response.dart';
import '../../../model/response_error.dart';

class SliderRepositoryApi {
  final box = Hive.box<String>(userDatabase);
  final _dio = Dio();
  //Need to get token from HiveLocalDatabase and put it in
  //the headers

  Future<SliderListResponse> searchSlider(
      {required String path, required String data}) async {
    Completer<SliderListResponse> completer = Completer();
    try {
      final response = await _dio.get(path, queryParameters: {
        "search": data,
      });
      if (response.statusCode == 200) {
        completer.complete(SliderListResponse.fromJson(response.data));
      } else {
        completer.complete(
            SliderListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        SliderListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }

  Future<bool> postSlider({
    required Map<String, dynamic> data,
    MessengerLink? messengerLink,
    FacebookLink? facebookLink,
    YoutubeLink? youtubeLink,
    List<int>? courseLink,
    Blog? blog,
  }) async {
    Completer<bool> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.post(sliderPath,
          data: FormData.fromMap(data),
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      final sliderID = response.data["id"];
      if (!(messengerLink == null)) {
        await _dio.post(messengerLinkPath,
            data: {
              "link": messengerLink.link,
              "slider": sliderID,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(facebookLink == null)) {
        await _dio.post(facebookLinkPath,
            data: {
              "link": facebookLink.link,
              "slider": sliderID,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(youtubeLink == null)) {
        await _dio.post(youtubeLinkPath,
            data: {
              "link": youtubeLink.link,
              "slider": sliderID,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(courseLink == null)) {
        await _dio.post(courseLinkPath,
            data: {
              "course": courseLink,
              "slider": sliderID,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(blog == null)) {
        await _dio.post(blogLinkPath,
            data: blog.toJson(),
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      completer.complete(true);
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }

  Future<bool> updateSlider({
    required Map<String, dynamic> data,
    MessengerLink? messengerLink,
    FacebookLink? facebookLink,
    YoutubeLink? youtubeLink,
    List<int>? courseLink,
    required List<int> previousCourseLink,
    Blog? blog,
    /*  int? messengerID,
    int? facebookID,
    int? youtubeID,
    int? courseID,
    int? blogID, */
    int? sliderID,
  }) async {
    Completer<bool> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.patch("$sliderPath$sliderID/",
          data: FormData.fromMap(data),
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (!(messengerLink == null)) {
        await _dio.patch("$messengerLinkPath${messengerLink.id}/",
            data: {
              "link": messengerLink.link,
              "slider": response.data["id"],
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(facebookLink == null)) {
        await _dio.patch("$facebookLinkPath${facebookLink.id}/",
            data: {
              "slider": response.data["id"],
              "link": facebookLink.link,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(youtubeLink == null)) {
        await _dio.patch("$youtubeLinkPath${youtubeLink.id}/",
            data: {
              "slider": response.data["id"],
              "link": youtubeLink.link,
            },
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      }
      if (!(courseLink == null)) {
        for (var courseId in previousCourseLink) {
          if (!courseLink.contains(courseId)) {
            //remove course
            await _dio.delete(
              "$courseLinkPath$courseId/",
            );
          }
        }
        for (var id in courseLink) {
          if (!previousCourseLink.contains(id)) {
            //new discount item,so post
            await _dio.post(courseLinkPath,
                data: {
                  "slider": response.data["id"],
                  "course": courseLink,
                },
                options: Options(headers: {
                  "Authorization": "JWT $key",
                }));
          }
        }
      }
      /*  if (!(blog == null) && !(blogID == null)) {
        await _dio.patch("$blogLinkPath$blogID/",
            data: blog.toJson(),
            options: Options(headers: {
              "Authorization": "JWT $key",
            }));
      } */
      completer.complete(true);
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }

  Future<bool> deleteSlider(int sliderID) async {
    Completer<bool> completer = Completer();
    final key = box.get(jwtKey, defaultValue: "") as String;

    try {
      final response = await _dio.delete("$sliderPath$sliderID/",
          options: Options(headers: {
            "Authorization": "JWT $key",
          }));
      if (response.statusCode == 204) {
        completer.complete(true);
      }
    } catch (e) {
      completer.complete(false);
    }
    return completer.future;
  }

  Future<SliderListResponse> getSlider(String path) async {
    Completer<SliderListResponse> completer = Completer();
    try {
      final response = await _dio.get(
        path,
      );
      if (response.statusCode == 200) {
        completer.complete(SliderListResponse.fromJson(response.data));
      } else {
        completer.complete(
            SliderListResponse(error: ResponseError.fromJson(response.data)));
      }
    } catch (e) {
      log("Error: $e");
      completer.complete(
        SliderListResponse(
          error: ResponseError(detail: "$e"),
        ),
      );
    }
    return completer.future;
  }
}
