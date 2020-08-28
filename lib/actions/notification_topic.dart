import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationTopic {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void subscribeToTopic(List<String> topics) {
    topics.forEach((e) => _firebaseMessaging.subscribeToTopic(e));
  }

  void unsubscribeFromTopic(List<String> topics) {
    topics.forEach((e) => _firebaseMessaging.unsubscribeFromTopic(e));
  }
}
