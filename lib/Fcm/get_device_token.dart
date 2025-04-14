import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GetDeviceToken{
  String? token;
  Future<void>getToken()async{
    FirebaseMessaging messaging=FirebaseMessaging.instance;
    token=await messaging.getToken();
   await FirebaseFirestore.instance.collection('Users').doc('Mohsin').set({
     'Device-Token':token,
     'Updated-on':DateTime.now()
   });
    print('Token=> $token');
  }
}