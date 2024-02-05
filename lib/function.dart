import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmlearning_admin/bloc/bloc/auth_bloc.dart';

Future<List<int>> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    return [];
  } else {
    return await image.readAsBytes();
  }
}

void showSuccessSnack({required BuildContext context, required String data}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        data,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w800,
            ),
      ),
    ));
}

void showErrorSnack({required BuildContext context, required String data}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        data,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.w800,
            ),
      ),
    ));
}

void showProfilePopupMenu(BuildContext context, Offset offset) async {
  final textTheme = Theme.of(context).textTheme;
  // Attempt to obtain the render object and cast it as RenderBox
  final RenderObject? overlayRenderObject =
      Overlay.of(context).context.findRenderObject();

  // Check if the render object is not null and is indeed a RenderBox
  if (overlayRenderObject != null && overlayRenderObject is RenderBox) {
    final RenderBox overlay = overlayRenderObject;
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        offset & const Size(30, 30), // Smaller rectangle, the touch area
        Offset.zero & overlay.size, // Bigger rectangle, the entire screen
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 'Option 1',
          onTap: () => context.read<AuthBloc>().add(AuthLogoutEvent()),
          child: Text(
            'Logout',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.red,
            ),
          ),
        ),
        /* const PopupMenuItem(
          value: 'Option 2',
          child: Text('Option 2'),
        ), */
        // Add more menu items if you like
      ],
    );
  } else {
    // Handle the case where overlayRenderObject is not a RenderBox or is null
    print("Error: Overlay render object is not a RenderBox or is null.");
  }
}

Future<Map<String, dynamic>?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  if (result != null) {
    Uint8List fileBytes = result.files.first.bytes!;
    String fileName = result.files.first.name;
    String mimeType = lookupMimeType(fileName) ?? '';
    return {
      "byte": fileBytes,
      "name": fileName,
      "mimeType": mimeType,
    };
  }
  return null;
}

Future<Map<String, dynamic>?> pickVideo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp4'],
  );
  if (result != null) {
    Uint8List fileBytes = result.files.first.bytes!;
    String fileName = result.files.first.name;
    String mimeType = lookupMimeType(fileName) ?? '';
    return {
      "byte": fileBytes,
      "name": fileName,
      "mimeType": mimeType,
    };
  }
  return null;
}

String createBlobUrl(Uint8List videoBytes, String mimeType) {
  // Create a blob from the byte array
  final blob = html.Blob([videoBytes], mimeType);
  // Create a URL for the blob
  final url = html.Url.createObjectUrlFromBlob(blob);
  return url;
}

Future<Uint8List?> fetchImage(
    String imageUrl, void Function(double v) progress) async {
  try {
    var dio = Dio();

    // Make the GET request
    Response<List<int>> response = await dio.get<List<int>>(
      imageUrl,
      onReceiveProgress: (count, total) {
        progress(count / total);
      },
      options: Options(
        responseType:
            ResponseType.bytes, // Ensures response is treated as bytes
      ),
    );

    // If request is successful, return the response body as Uint8List
    return Uint8List.fromList(response
        .data!); /* ; else {
      print('Failed to load image');
      return null;
    } */
  } catch (e) {
    print('Error fetching image: $e');
    return null;
  }
}

Future<Map<String, dynamic>> fetchVideo(
    String videoUrl, void Function(double v) progress) async {
  try {
    var dio = Dio();

    // Make the GET request
    Response<List<int>> response = await dio.get<List<int>>(
      videoUrl,
      onReceiveProgress: (count, total) {
        progress(count / total);
      },
      options: Options(
        responseType:
            ResponseType.bytes, // Ensures response is treated as bytes
      ),
    );
    if (response.statusCode == 200) {
      Uint8List fileBytes = Uint8List.fromList(response.data!);
      String fileName = Uri.parse(videoUrl).pathSegments.last;
      String mimeType = lookupMimeType(fileName) ?? '';
      return {
        "byte": fileBytes,
        "name": fileName,
        "mimeType": mimeType,
      };
    } else {
      log('*******Failed to load image');
      return {};
    }
  } catch (e) {
    log('******Error fetching image: $e');
    return {};
  }
}
