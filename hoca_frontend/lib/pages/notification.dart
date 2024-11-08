import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoca_frontend/classes/caller.dart';
import 'package:hoca_frontend/components/noti/buildnotificationcard.dart';
import 'package:hoca_frontend/models/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<Notifications> notificationsList = [];
  bool hasNewNoti = false; // To track unseen notifications
  Timer? _pollingTimer;
  String? lastFetchedNotiID;

  @override
  void initState() {
    super.initState();
    init();
    _startPolling();
  }

  Future<void> _refreshNotifications() async {
    init(); // Fetch notifications again
    setState(() {}); // Rebuild the widget with the updated data
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Caller.dio.get(
        "/v1/notification/",
        options: Options(
          headers: {
            'x-auth-token': '$token', // Add token to header
          },
        ),
      );

      setState(() {
        print(response.data);
        notificationsList = (response.data as List)
            .map((notiJson) => Notifications.fromJson(notiJson))
            .toList();

        if (notificationsList.isNotEmpty) {
          String latestNotiID = notificationsList.first.notiID.toString();

          // If the latest notiID is different from the last fetched one, mark it as new
          if (lastFetchedNotiID == null || lastFetchedNotiID != latestNotiID) {
            hasNewNoti = true; // There's a new notification
            lastFetchedNotiID = latestNotiID; // Update the last fetched ID
            prefs.setBool('hasNewNoti', true);
          } else {
            hasNewNoti = false; // No new notification
          }
        }
      });
    } catch (error) {
      if (error is DioException) {
        Caller.handle(context, error);
      } else {
        // Handle other types of errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred while fetching notifications.'),
          ),
        );
      }
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      init(); // Fetch notifications every 30 seconds
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const notificationTypes = {
      "confirmation": "Please confirm a new order within 7 minutes otherwise it will be cancel automatically",
      "preparing": "Your order has been confirmed and waiting for a houseworker to prepare",
      "working": "The worker has been arrived and ready to work",
      "complete": "Your order is complete. Please rate the experience of a worker",
      "user_cancel": "Your order has been cancel from a customer",
      "worker_cancel": "Your order has been cancel from a worker",
      "system_cancel": "The order has been cancel due to no confirmation from the houseworker",
      "user_rating": "rated your post",
    };

    const notificationTitles = {
      "confirmation": "Confirmation",
      "preparing": "Preparing",
      "working": "Working",
      "complete": "Complete",
      "user_cancel": "User Cancel",
      "worker_cancel": "Worker Cancel",
      "system_cancel": "System Cancel",
      "user_rating": "User Rating",
    };

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF87C4FF).withOpacity(0.6), // 60% opacity
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        'Notification',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Add some spacing
            Expanded(
              child: notificationsList.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: notificationsList.length,
                      itemBuilder: (context, index) {
                        Notifications notification = notificationsList[index];
                        String title = notificationTitles[notification.type] ?? 'Unknown Notification';
                        String message = notificationTypes[notification.type] ?? 'No message available';

                        Color titleColor;
                        if (notification.type == "complete") {
                          titleColor = Colors.green; // Green for Complete
                        } else if (notification.type == "confirmation") {
                          titleColor = Colors.blue; // Blue for Confirmation
                        } else if (notification.type == "user_cancel" ||
                                   notification.type == "worker_cancel" ||
                                   notification.type == "system_cancel") {
                          titleColor = Colors.red;
                        } else {
                          titleColor = Colors.black;
                        }

                        return buildNotificationCard(
                          imageUrl: notification.avatar!,
                          title: title,
                          message: message,
                          titleColor: titleColor,
                        );
                      },
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none, // Bell icon
                            size: 48.0,
                            color: Colors.grey, // Customize color if needed
                          ),
                          SizedBox(height: 8.0), // Spacing between icon and text
                          Text(
                            "No notification yet",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey, // Customize color if needed
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}