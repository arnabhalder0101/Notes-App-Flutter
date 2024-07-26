import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:note_tracker/Models/notes_databade.dart';
import 'package:note_tracker/pages/homepage.dart';
import 'package:note_tracker/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize Isar DB before calling any other methods. in main();
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDatabasse.initialize();
  //
  runApp(
    MultiProvider(providers: [
      // Note database provider --
      ChangeNotifierProvider(create: (context) => NotesDatabasse()),
      // Theme provider --
      ChangeNotifierProvider(create: (context) => ThemeProvider()),

    ],
    child: MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
