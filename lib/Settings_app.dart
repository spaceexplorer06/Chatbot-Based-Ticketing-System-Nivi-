import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      backgroundColor: themeNotifier.themeMode == ThemeMode.dark
          ? Colors.black
          : const Color.fromARGB(255, 158, 220, 160),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Dark Mode Setting
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: themeNotifier.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeNotifier.toggleTheme(value);
              },
            ),
          ),

          // Notifications Setting
          ListTile(
            title: const Text("Enable Notifications"),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),

          // Language Selection
          ListTile(
            title: const Text("Language"),
            subtitle: Text(_selectedLanguage),
            onTap: () async {
              String? selected = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Select Language'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'English');
                        },
                        child: const Text('English'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'Spanish');
                        },
                        child: const Text('Spanish'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 'French');
                        },
                        child: const Text('French'),
                      ),
                    ],
                  );
                },
              );
              if (selected != null) {
                setState(() {
                  _selectedLanguage = selected;
                });
              }
            },
          ),

          // Account Preferences
          ListTile(
            title: const Text("Account Preferences"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to account preferences page (to be implemented)
            },
          ),
        ],
      ),
    );
  }
}
