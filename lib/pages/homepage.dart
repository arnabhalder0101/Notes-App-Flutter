import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isar/isar.dart';
import 'package:note_tracker/Models/Note.dart';
import 'package:note_tracker/Models/notesTile.dart';
import 'package:note_tracker/Models/notes_databade.dart';
import 'package:note_tracker/pages/settings_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch notes --
    context.read<NotesDatabasse>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    List<Note> allNotes = context.watch<NotesDatabasse>().currentNotes;
    final txtCtrlHeading = TextEditingController();
    final txtCtrlMain = TextEditingController();
    // add notes --
    void addNoteinHome() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: TextField(
            controller: txtCtrlHeading,
            decoration: InputDecoration(hintText: "Enter note title"),
            maxLines: null,
          ),
          content: TextField(
            controller: txtCtrlMain,
            decoration: InputDecoration(hintText: "Enter note content..."),
            maxLines: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context
                    .read<NotesDatabasse>()
                    .addNote(txtCtrlHeading.text, txtCtrlMain.text);
                Navigator.pop(context);
                // toast --
                Fluttertoast.showToast(
                  msg: "New Note Created...",
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                );
              },
              child: Text(
                "Create",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(child: Text("N O T E S")),
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

      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                r"assets\splash\logo_note_tracker.png",
                height: 70,
                width: 70,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home_rounded),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("A B O U T"),
              leading: Icon(Icons.info_outline),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // floating create button--

      floatingActionButton: FloatingActionButton(
        onPressed: addNoteinHome,
        child: Icon(
          Icons.add,
          color: Colors.black54,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
        child: Column(
          children: [
            // show text --
            Text(
              "Your Notes ",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
            ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  final individualNotes = allNotes[index];
                  return NotesTile(
                    note: individualNotes,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
