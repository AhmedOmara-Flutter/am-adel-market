import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import 'package:am_adel_market/core/services/service_locator.dart';
import 'package:am_adel_market/core/utils/navigation_key.dart';
import 'package:am_adel_market/core/utils/route_manager.dart';

class NotificationServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'pizza_sofian_channel',
    'Pizza Sofian Notifications',
    description: 'Notifications for Pizza Sofian',
    importance: Importance.max,
    playSound: true,
  );

  // =========================================================
  // Local Notification
  // =========================================================

  static Future<void> initLocal() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        print('🔔 Local notification clicked');
        print('📦 Payload: ${response.payload}');

        if (response.payload == null ||
            response.payload!.isEmpty) {
          return;
        }

        try {
          final Map<String, dynamic> data =
          jsonDecode(response.payload!);

          _handleNotificationNavigation(data);
        } catch (e) {
          print('❌ Notification payload error: $e');
        }
      },
    );

    final AndroidFlutterLocalNotificationsPlugin? android =
    _local.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.createNotificationChannel(_channel);

    await android?.requestNotificationsPermission();
  }

  // =========================================================
  // Show Notification - Foreground
  // =========================================================

  static Future<void> showNotification(
      RemoteMessage message,
      ) async {
    final RemoteNotification? notification =
        message.notification;

    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      notification?.title ?? 'إشعار جديد',
      notification?.body ?? '',
      details,

      // مهم جدًا
      payload: jsonEncode(message.data),
    );
  }

  // =========================================================
  // Notification Navigation
  // =========================================================

  static void _handleNotificationNavigation(
      Map<String, dynamic> data,
      ) {
    print('🚀 Notification navigation');
    print('📦 Data: $data');

    final String? screen = data['screen']?.toString();

    if (screen == null || screen.isEmpty) {
      print('⚠️ No screen found');
      return;
    }

    switch (screen) {
      case 'product':
        final String? productId =
        data['productId']?.toString();

        if (productId == null || productId.isEmpty) {
          print('⚠️ productId is missing');
          return;
        }

        navigatorKey.currentState?.pushNamed(
          RouteManager.productDetails,
          arguments: productId,
        );

        break;

      case 'orders':
        navigatorKey.currentState?.pushNamed(
          RouteManager.orders,
        );

        break;

      case 'coupon':
        navigatorKey.currentState?.pushNamed(
          RouteManager.coupon,
        );

        break;

      case 'home':
        navigatorKey.currentState?.pushNamed(
          RouteManager.home,
        );

        break;

      default:
        print('⚠️ Unknown notification screen: $screen');
    }
  }

  // =========================================================
  // Save FCM Token
  // =========================================================

  static Future<void> saveFcmToken() async {
    try {
      final User? user =
          FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('⚠️ No logged in user');
        return;
      }

      final String? token =
      await _firebaseMessaging.getToken();

      if (token == null || token.isEmpty) {
        print('⚠️ FCM Token is null');
        return;
      }

      await instance<DatabaseServices>().updateData(
        path: 'users',
        docId: user.uid,
        data: {
          'fcmToken': token,
        },
      );

      print('======================================');
      print('✅ FCM TOKEN SAVED');
      print('======================================');
    } catch (e) {
      print('❌ Error saving FCM Token: $e');
    }
  }

  // =========================================================
  // Firebase
  // =========================================================

  static Future<void> initFirebase() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.subscribeToTopic(
      'all_users',
    );

    await saveFcmToken();

    // Token Refresh
    _firebaseMessaging.onTokenRefresh.listen(
          (String token) async {
        try {
          final User? user =
              FirebaseAuth.instance.currentUser;

          if (user == null) {
            print('⚠️ No logged in user');
            return;
          }

          await instance<DatabaseServices>().updateData(
            path: 'users',
            docId: user.uid,
            data: {
              'fcmToken': token,
            },
          );

          print('🔄 FCM Token updated');
        } catch (e) {
          print('❌ Error updating FCM Token: $e');
        }
      },
    );

    // Foreground
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        print('📩 FOREGROUND MESSAGE');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');

        if (message.notification != null) {
          await showNotification(message);
        }
      },
    );

    // Background
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        print('🔔 Notification opened from background');
        print('Data: ${message.data}');

        _handleNotificationNavigation(
          message.data,
        );
      },
    );

    // Terminated
    final RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      print('🔔 App opened from terminated state');
      print('Data: ${initialMessage.data}');

      _handleNotificationNavigation(
        initialMessage.data,
      );
    }
  }
}