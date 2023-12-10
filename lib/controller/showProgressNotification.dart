import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String _channelId = 'your_channel_id';
const String _channelName = 'Your Channel Name';
const String _channelDesc = 'Your Channel Description';

Future<void> showProgressNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var maxProgress = 5;
  for (var i = 0; i <= maxProgress; i++) {
    await Future.delayed(Duration(seconds: 1), () async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDesc,
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: maxProgress,
        progress: i,
      );

      var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
          0,
        'progress notification title',
        'progress notification body',
        platformChannelSpecifics,
        payload: 'item x',
      );
    });
  }
}