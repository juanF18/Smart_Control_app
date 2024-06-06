import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

class MqttRepository {
  final MqttServerClient client;
  Function(String)? onMessageReceived;

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

  void _onMessage(List<MqttReceivedMessage<MqttMessage>> event) {
    final MqttPublishMessage message = event[0].payload as MqttPublishMessage;
    final payload =
        String.fromCharCodes(message.payload.message as Iterable<int>);

    if (onMessageReceived != null) {
      onMessageReceived!(payload);
    }
  }

  Future<void> connect() async {
    try {
      await client.connect();
      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        print('Connected');
        client.updates?.listen(_onMessage);
      }
    } on Exception catch (e) {
      print('Exception: $e');
      client.disconnect();
      _attemptReconnect();
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

  Future<void> subscribe(String topic) async {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.atLeastOnce);
    } else {
      print("No esta conectado");
    }
  }

  void _attemptReconnect() async {
    await Future.delayed(const Duration(seconds: 5));
    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      await connect();
    }
  }
}
