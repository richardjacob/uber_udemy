import 'package:drivers_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging() async {
    // 1. Terminated
    // when the app is completely closed and opened directly from the push notification

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        // display ride request information - user info who request a ride
      }
    });

    // 2. Foreground
    // when the app is open and it receives a push notification

    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      // display ride request information - user info who request a ride
    });

    // 3. background
    // When the app is in the background and opened directly from the push notification.

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      // display ride request info - user indo who request a ride
    });
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();

    print('FCM Registration Token: ');
    print(registrationToken);

    FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(currentFirebaseUser!.uid)
        .child('token')
        .set(registrationToken);
    messaging.subscribeToTopic('allDrivers');
    messaging.subscribeToTopic('allUsers');
  }
}
