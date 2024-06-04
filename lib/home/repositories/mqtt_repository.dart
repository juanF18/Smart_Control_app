import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

class MqttRepository {
  final MqttServerClient client;

  MqttRepository(String serverUri, String clientId)
      : client = MqttServerClient(serverUri, clientId) {
    _initializeMqttClient();
  }

  void _initializeMqttClient() {
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.onUnsubscribed = onUnsubscribed;
    client.pongCallback = pong;
  }

  Future<void> connect() async {
    try {
      await client.connect();
    } on Exception catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(MqttSubscription subscription) {
    print('Subscribed to ${subscription.topic}');
  }

  void onSubscribeFail(MqttSubscription subscription) {
    print('Failed to subscribe ${subscription.topic}');
  }

  void onUnsubscribed(MqttSubscription? subscription) {
    print('Unsubscribed from ${subscription?.topic}');
  }

  void pong() {
    print('Ping response client callback invoked');
  }

  Future<void> publishMessage(String topic, String message) async {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      final builder = MqttPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    } else {
      print("No esta conectado");
    }
  }
}
