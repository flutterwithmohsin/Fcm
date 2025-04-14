import 'package:http/http.dart' as http;
import 'dart:convert';

class FCMService {
  final String serverKey;
  final String projectId;

  FCMService({required this.serverKey, required this.projectId});

  Future<void> sendNotifications({
    required List<String> tokens,
    required String title,
    required String body
  }) async {
    final url = Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    for (String token in tokens) {
      final payload = {
        'message': {
          'token': token,
          'notification': {
            'title': title,
            'body': body
          }
        }
      };

      try {
        final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $serverKey'
            },
            body: jsonEncode(payload)
        );

        print('Notification result for $token: ${response.statusCode}');
      } catch (e) {
        print('Error sending notification to $token: $e');
      }
    }
  }
}

// Example usage
void sendNotification() {
  final fcmService = FCMService(
      serverKey: 'YOUR_SERVER_KEY',
      projectId: 'YOUR_PROJECT_ID'
  );

  fcmService.sendNotifications(
      tokens: ['device_token1', 'device_token2'],
      title: 'Notification Title',
      body: 'Notification Body'
  );
}