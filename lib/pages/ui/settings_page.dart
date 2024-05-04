import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List settings = [
      'Setting 1',
      'Setting 2',
      'Setting 3',
      'Setting 4',
      'Setting 5',
      'Setting 6',
      'Setting 7',
      'Setting 8',
      'Setting 9',
      'Setting 10',
    ];
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Scrollbar(
        interactive: true,
        radius: const Radius.circular(10),
        child: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${settings[index]}'),
            );
          },
        ),
      ),
    );
  }
}
