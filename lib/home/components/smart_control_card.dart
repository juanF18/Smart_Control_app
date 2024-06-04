import 'package:flutter/material.dart';

class SmartControlCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool initialValue;
  final Function(bool) onChanged;
  const SmartControlCard(
      {super.key,
      required this.label,
      required this.icon,
      required this.initialValue,
      required this.onChanged});

  @override
  State<SmartControlCard> createState() => _SmartControlCardState();
}

class _SmartControlCardState extends State<SmartControlCard> {
  late bool value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  void _handleTap() {
    setState(() {
      value = !value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: value ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: value ? Colors.green : Colors.black,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: value ? Colors.green : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Switch(
              value: value,
              onChanged: (bool newValue) {
                setState(() {
                  value = newValue;
                });
                widget.onChanged(newValue);
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
