import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/view/widgets/confirmation_widget.dart';
import 'package:provider/provider.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/view/screens/createoreditpage.dart';

class NoteViewOptions extends StatelessWidget {
  final Note note;

  const NoteViewOptions({super.key, required this.note});

  static Future<void> show(BuildContext context, Note note) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => NoteViewOptions(note: note),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Iconsax.book_saved),
            title: const Text('Open'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Iconsax.receipt_edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => ChangeNotifierProvider(
                        create: (_) => NewNoteController()..note = note,
                        child: const Createoreditpage(
                          isNewNote: false,
                          readOnly: false,
                        ),
                      ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Iconsax.trash),
            title: const Text('Delete'),
            onTap: () async {
              final bool? confirmed = await showDialog<bool>(
                context: context,
                builder:
                    (_) => ConfirmationWidget(
                      title: 'Delete Note',
                      message: 'Are you sure you want to delete this note?',
                      confirmText: 'Delete',
                      cancelText: 'Cancel',
                    ),
              );

              if (confirmed == true) {
                final notesController = Provider.of<NotesController>(
                  context,
                  listen: false,
                );
                Navigator.pop(context);
                notesController.deleteNoteFile(note);
                notesController.removeNote(note);
              }
            },
          ),
        ],
      ),
    );
  }
}
