import 'package:flutter/material.dart';
import 'package:smart_control_hub_app/home/components/smart_control_card.dart';
import 'package:smart_control_hub_app/home/components/smart_info_card.dart';

class SmartHomeControl extends StatefulWidget {
  const SmartHomeControl({super.key});

  @override
  State<SmartHomeControl> createState() => _SmartHomeControlState();
}

class _SmartHomeControlState extends State<SmartHomeControl> {
  bool isLightOn = false;
  bool isDoorOpen = false;
  bool isFanOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'SmartControl Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[600],
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
                }),
            SmartControlCard(
                label: 'Puerta',
                icon: Icons.door_front_door,
                initialValue: isLightOn,
                onChanged: (value) {
                  setState(() {
                    isDoorOpen = value;
                  });
                }),
            SmartControlCard(
                label: 'Ventilador',
                icon: Icons.mode_fan_off,
                initialValue: isLightOn,
                onChanged: (value) {
                  setState(() {
                    isFanOn = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
