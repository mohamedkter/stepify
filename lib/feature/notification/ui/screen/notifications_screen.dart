import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? _token;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
      setState(() {
        _token = token;
      });
    });

    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground Message: ${message.notification?.title}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message.notification?.title ?? 'New Notification')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(
        child: Text("Device Token:\n$_token"),
      ),
    );
  }
}