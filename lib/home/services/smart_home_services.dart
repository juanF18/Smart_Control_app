import 'package:smart_control_hub_app/home/repositories/mqtt_repository.dart';

class SmartHomeServices {
  final MqttRepository _mqttRepository;
  final String topic;

  SmartHomeServices(String serverUri, String clientId, this.topic)
      : _mqttRepository = MqttRepository(serverUri, clientId);

  Future<void> connectToMqtt() async {
    await _mqttRepository.connect();
  }

  void disconnectFromMqtt() {
    _mqttRepository.disconnect();
  }

  Future<void> sendMessage(String message) async {
    await _mqttRepository.publishMessage(topic, message);
  }
}
