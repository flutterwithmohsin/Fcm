import 'package:fcm/Fcm/get_device_token.dart';
import 'package:fcm/Fcm/notification_service.dart';
import 'package:fcm/Fcm/send__notification_service.dart';
import 'package:flutter/material.dart';

import 'Fcm/get_server_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
 GetDeviceToken getDeviceToken=GetDeviceToken();
  NotificationService notificationService=NotificationService();

  ontheload()async{
    GetServerKey getServerKey=GetServerKey();
    String serverKey=await getServerKey.getServerKeyToken();
    print(serverKey);
    getDeviceToken.getToken();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
  }
  TextEditingController title=TextEditingController();
  TextEditingController body=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fcm',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
       padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Notification Title'
              ),
            ),
            TextFormField(
              controller: body,
              decoration: InputDecoration(
                hintText: 'Notification body'
              ),
            ),
            Center(child: MaterialButton(
              height: 45,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Send Notification',),
                onPressed: (){
              SendNotificationService.sendNotificationUsingApi(
                  token: "eNEruF8oTlWPZm75hToJmP:APA91bGNGjxzxVjsExD-3HbbSTnPYkztWM59Q9UwYZH27jwdB3l-uuh00yx3ipvi_AxrWvWAtJGumLTvMTd1SEQAYwnxKg1zXpoAXqPpuYMgLO8GhXkb81E",
                  title:title.text.trim(),
                  body:body.text.trim() ,
                  data: {
                    'Screen': 'HomeScreen'
                  });
              title.clear();
              body.clear();
             })
              ,)
          ],
        ),
      ),
    );
  }
}