import 'package:flutter/material.dart';

class SettingsTenant extends StatelessWidget {
  const SettingsTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
          ),
          title: Text('Bernice Mensah'),
        ),
      ),
    );
  }
}
