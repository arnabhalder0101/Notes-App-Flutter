import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_tracker/Models/notes_databade.dart';
import 'package:provider/provider.dart';

import 'Note.dart';

class NotesTile extends StatelessWidget {
  Note note;
  NotesTile({super.key, required this.note});

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
          backgroundColor: Theme.of(context).colorScheme.background,
          title: TextField(
            controller: txtCtrlHeading,
            decoration: InputDecoration(hintText: "Note Title"),
            maxLines: null,
          ),
          content: TextField(
            controller: txtCtrlMain,
            decoration:
                InputDecoration(hintText: "Enter updated note content..."),
            maxLines: null,
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
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    textColor: Theme.of(context).colorScheme.inversePrimary,
                  );
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ))
          ],
        ),
      );
    }

    // delete --

    void Function()? deleteNote(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "Delete Alert!",
            style: TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text("Want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                context.read<NotesDatabasse>().deleteNote(note.id);
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Note Deleted",
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                );
              },
              child: Text(
                "Sure",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            )
          ],
        ),
      );
    }

    final String noteName;

    if (note.name == null || note.name == "") {
      noteName = "Note Title";
    } else {
      noteName = note.name;
    }

    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteNote,
              icon: Icons.delete_outline_rounded,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
              spacing: 0,
            )
          ],
        ),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: ListTile(
            tileColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  noteName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),

                // divider

                SizedBox(
                  height: 12,
                ),

                // content
                Text(note.text),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: editNote, icon: Icon(Icons.edit_note_rounded)),
                // IconButton(
                //     onPressed: () {
                //       deleteNote(context);
                //     },
                //     icon: Icon(Icons.delete_outline_rounded)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
