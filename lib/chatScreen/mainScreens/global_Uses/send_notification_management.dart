import 'dart:convert';

import 'package:http/http.dart';
import 'package:medskin/chatScreen/mainScreens/global_Uses/enum_generation.dart';

class SendNotification {
  Future<void> messageNotificationClassifier(ChatMessageTypes messageTypes,
      {String textMsg = "",
      String connectionToken,
      String currAccountUserName}) async {
    switch (messageTypes) {
      case ChatMessageTypes.None:
        break;
      case ChatMessageTypes.Text:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Message",
            body: textMsg);
        break;
      case ChatMessageTypes.Image:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Image",
            body: "");
        break;
      case ChatMessageTypes.Video:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Video",
            body: "");
        break;
      case ChatMessageTypes.Document:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Document",
            body: "");
        break;
      case ChatMessageTypes.Audio:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Audio",
            body: "");
        break;
      case ChatMessageTypes.Location:
        await sendNotification(
            token: connectionToken,
            title: "$currAccountUserName Send a Location",
            body: "");
        break;
    }
  }

  Future<int> sendNotification(
      {String token,
       String title,
      String body}) async {
    try {
      print("In Notification");

      final String _serverKey =
          "AAAAV3Z3Vak:APA91bEqAU5eLhyj74LSWzmOFQgw6ZjTET3zoQqeEaJzIhAQ7B69kcZgrLi3zt5Tr7MYJGuPJT9EYP354rjapYUVsBQvGs2RK9QNY3DI5lQ9qy9IpXp4DtUaw-GK2d5_3PACLWCeBdSU";

      final Response response = await post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "key=$_serverKey",
        },
        body: jsonEncode(<String, dynamic>{
          "notification": <String, dynamic>{
            "body": body,
            "title": title,
          },
          "priority": "high",
          "data": <String, dynamic>{
            "click": "android.intent.action.MAIN",
            "id": "1",
            "status": "done",
            "collapse_key": "type_a",
          },
          "to": token,
        }),
      );

      print("Response is: ${response.statusCode}   ${response.body}");

      return response.statusCode;
    } catch (e) {
      print("Error in Notification Send: ${e.toString()}");
      return 404;
    }
  }
}
