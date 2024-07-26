import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_tracker/Models/notes_databade.dart';

import 'package:provider/provider.dart';

import 'Note.dart';

class NotesTile2 extends StatelessWidget {
  Note note;
  NotesTile2({super.key, required this.note});

  final txtCtrlHeading = TextEditingController();

  final txtCtrlMain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final notesObj = context.watch<NotesDatabasse>();

    // update --
    void editNote() {
      txtCtrlHeading.text = note.name;
      txtCtrlMain.text = note.text;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.yellow[100],
          title: TextField(
            controller: txtCtrlHeading,
            decoration: InputDecoration(hintText: "Note Title"),
          ),
          content: TextField(
            controller: txtCtrlMain,
            decoration:
                InputDecoration(hintText: "Enter updated note content..."),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  context.read<NotesDatabasse>().updateNote(
                      note.id, txtCtrlHeading.text, txtCtrlMain.text);
                  txtCtrlHeading.clear();
                  txtCtrlMain.clear();
                  Navigator.pop(context);
                  // toast --
                  Fluttertoast.showToast(
                      msg: "Content Updated Successfully...",
                      backgroundColor: Colors.yellow[200],
                      textColor: Colors.black);
                },
                child: Text("Update"))
          ],
        ),
      );
    }

    // delete --
    void deleteNote() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.yellow[100],
          title: Text(
            "Delete Alert!",
            style:
                TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold),
          ),
          content: Text("Want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                context.read<NotesDatabasse>().deleteNote(note.id);
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Note Deleted",
                    backgroundColor: Colors.yellow[200],
                    textColor: Colors.black);
              },
              child: Text("Sure"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
        ),
      );
    }

    String noteName;

    if (note.name == null || note.name == "") {
      noteName = "Note ${note.id}";
    } else {
      noteName = note.name;
    }

    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 13),
        child: Container(
          child: Column(
            children: [
              // title --
              Text(
                noteName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),

              // divider

              SizedBox(
                height: 12,
              ),
              // row --
              Row(
                children: [
                  // content
                  Text(note.text),

                  // Icon buttons --
                  IconButton(
                      onPressed: editNote, icon: Icon(Icons.edit_note_rounded)),
                  IconButton(
                      onPressed: deleteNote,
                      icon: Icon(Icons.delete_outline_rounded)),
                ],
              )
            ],
          ),
        ));
  }
}
