import 'package:flutter/material.dart';
import 'package:smart_control_hub_app/home/components/smart_control_card.dart';
import 'package:smart_control_hub_app/home/components/smart_info_card.dart';
import 'package:smart_control_hub_app/home/services/smart_home_services.dart';

class SmartHomeControl extends StatefulWidget {
  const SmartHomeControl({super.key});

  @override
  State<SmartHomeControl> createState() => _SmartHomeControlState();
}

class _SmartHomeControlState extends State<SmartHomeControl> {
  bool isLightOn = false;
  bool isDoorOpen = false;
  bool isFanOn = false;

  late SmartHomeServices smartHomeService;

  @override
  void initState() {
    smartHomeService =
        SmartHomeServices('broker.hivemq.com', 'HomeSmartApp', 'sensorData');
    _connectToMqtt();
    super.initState();
  }

  Future<void> _connectToMqtt() async {
    await smartHomeService.connectToMqtt();
  }

  void _printValues() async {
    final String message = '$isLightOn|$isDoorOpen|$isFanOn';
    await smartHomeService.sendMessage(message);
  }

  @override
  void dispose() {
    smartHomeService.disconnectFromMqtt();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'SmartControl Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            const SmartInfoCard(
              label: "Humedad",
              icon: Icons.water_drop,
            ),
            const SmartInfoCard(
              label: "Temperatura",
              icon: Icons.thermostat,
            ),
            SmartControlCard(
                label: 'Luz',
                icon: Icons.lightbulb_outline,
                initialValue: isLightOn,
                onChanged: (valueLight) {
                  setState(() {
                    isLightOn = valueLight;
                  });
                  _printValues();
                }),
            SmartControlCard(
                label: 'Puerta',
                icon: Icons.door_front_door,
                initialValue: isLightOn,
                onChanged: (value) {
                  setState(() {
                    isDoorOpen = value;
                  });
                  _printValues();
                }),
            SmartControlCard(
                label: 'Ventilador',
                icon: Icons.mode_fan_off,
                initialValue: isLightOn,
                onChanged: (value) {
                  setState(() {
                    isFanOn = value;
                  });
                  _printValues();
                }),
          ],
        ),
      ),
    );
  }
}
