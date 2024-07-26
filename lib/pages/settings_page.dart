import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider tp = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("S E T T I N G S")),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.background,
          fontSize: 25,
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mode --
            Text(
              "Dark Mode",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            // Switch --

            CupertinoSwitch(
              value: tp.isDark,
              onChanged: (value) => tp.toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
