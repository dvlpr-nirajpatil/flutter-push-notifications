import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notify/services/auth_service.dart';

class NotificationService {
  String? token;
  NotificationService.internal();
  static NotificationService _instance = NotificationService.internal();
  static get instance => _instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void init() async {
    NotificationSettings settings = await messaging.getNotificationSettings();

    log(settings.authorizationStatus.toString(), name: "NOTIFICATION SETTING");

    if (settings.authorizationStatus == AuthorizationStatus.denied ||
        settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          criticalAlert: true,
          provisional: true);
      log(settings.authorizationStatus.toString(), name: "PERMISSON STATUS");
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      token = await messaging.getToken();
      storeFcmToken();

      messaging.onTokenRefresh.listen((token) {
        this.token = token;
        storeFcmToken();
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("title : ${message.notification?.title} \n body : ${message.notification?.body}",
            name: "NOTIFICATION");
      });

      log(token!, name: "FCM TOKEN");
    }
  }

  storeFcmToken() {
    if (Auth.instance.isLogin) {
      FirebaseFirestore.instance
          .collection('tokens')
          .doc(Auth.instance.uid)
          .set(
        {'token': token},
      ).then((value) {
        log("TOKEN STORED IN DATABASE", name: "FCM");
      });
    }
  }
}
