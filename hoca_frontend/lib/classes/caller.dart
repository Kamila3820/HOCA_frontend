import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class Caller {
  static BaseOptions options = BaseOptions(
    baseUrl: "http://shared1.bsthun.in:10605/",
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 8),
  );

  static Dio dio = Dio(options);

  static setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static handle(BuildContext context, DioError error) {
    print("Error: ${error.message}");

    if (error.response == null) {
      FlutterPlatformAlert.showAlert(
        windowTitle: 'Something went wrong',
        text: error.message ?? "Unknown error",
      );
      return;
    }

    // Safely handle null values in error messages
    String message = error.response!.data?["message"] ?? "An error occurred";
    String? errorDetails = error.response!.data?["error"]; // Can be null

    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      backgroundColor: const Color(0xffB00020),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message), // Ensure message is always non-null
          if (errorDetails != null) // Only show error details if present
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                errorDetails,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      backgroundColor: const Color(0xffB00020),
      content: Text(message),
    ));
  }

  static inform(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(15),
      content: Text(message),
    ));
  }
}
