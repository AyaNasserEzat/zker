import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{
 static   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static    Future init()async{

       AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
        final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
 );
         await flutterLocalNotificationsPlugin.initialize(initializationSettings,
);
      }

}