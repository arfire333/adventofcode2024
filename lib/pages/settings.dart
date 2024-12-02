import 'dart:async';
import 'package:adventofcode2024/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer' as dev;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  String _sessionToken = '';

  Future<void> getToken() async {
    var token = await prefs.getString('session');
    setState(() => _sessionToken = token ?? '');
  }

  Future<void> saveToken(String value) async {
    prefs.setString('session', value);
    setState(() => _sessionToken = value);
  }

  Future<void> deleteToken() async {
    prefs.remove('session');
    setState(() => _sessionToken = '');
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(settingsTitle)),
      body: ListView(padding: const EdgeInsets.all(8.0), children: [
        ListTile(
          title: const Text('Session Token'),
          trailing: FractionallySizedBox(
            widthFactor: .7,
            heightFactor: 1,
            child: Row(children: [
              Flexible(
                child: TextField(
                    controller: TextEditingController()..text = _sessionToken,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Session Token'),
                    onSubmitted: saveToken),
              ),
              IconButton(
                icon: const Icon(Icons.restore),
                onPressed: () => getToken(),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteToken(),
              ),
            ]),
          ),
        ),
        ListTile(
          title: const Text('Clear Cached Data'),
          trailing: FractionallySizedBox(
            widthFactor: .7,
            heightFactor: 1,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                var year = 2024;
                for (int day = 1; day <= 25; day++) {
                  prefs.remove('$year$day').catchError(
                      (e) => dev.log("No data removed for $year$day"));
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
