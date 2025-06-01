//flutter build apk --release --target-platform=android-arm64
//build/app/outputs/flutter-apk/app-release.apk

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/utilities/catagoriesoption.dart';
import 'package:notes/view/screens/createoreditpage.dart';
import 'package:notes/view/widgets/note_card_gridview.dart';
import 'package:notes/view/widgets/filter_catagory.dart';
import 'package:notes/view/widgets/filter_options.dart';
import 'package:notes/view/widgets/floatinbutton.dart';
import 'package:notes/view/widgets/empty_notes_view.dart';
import 'package:notes/view/widgets/notesdrawer.dart';
import 'package:notes/view/widgets/search_box.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;
  bool isFilterApplied = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notionary',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.filter),
            onPressed: () async {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final Offset position = box.localToGlobal(Offset.zero);

              await showDateFilterDropdownMenu(
                context: context,
                position: position,
                currentSelection: isFilterApplied ? 'modified' : 'created',
                onSelected: (selected) {
                  setState(() {
                    isFilterApplied = selected == 'modified';
                  });
                },
              );
            },
          ),

          const SizedBox(width: 2),
        ],
      ),
      drawer: NotesDrawer(),
      body: Consumer<NotesController>(
        builder: (BuildContext context, NotesController value, child) {
          final List<Note> notes = value.notes;
          List<Note> filteredNotes;

          if (selectedCategory == 0) {
            filteredNotes = [...notes];
          } else {
            filteredNotes =
                notes
                    .where(
                      (note) =>
                          note.category ==
                          Catagories().categories[selectedCategory],
                    )
                    .toList();
          }

          if (isFilterApplied) {
            filteredNotes.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
          } else {
            filteredNotes.sort((b, a) => b.createdAt.compareTo(a.createdAt));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBox(),
                const SizedBox(height: 16),
                FilterCatagory(
                  filteredNotes: filteredNotes,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (int index) {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                ),
                const SizedBox(height: 16),
                notes.isEmpty
                    ? NoNotes()
                    : NoteCardGrid(filteredNotes: filteredNotes),
              ],
            ),
          );
        },
      ),
      floatingActionButton: HomeFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChangeNotifierProvider(
                    create: (BuildContext context) => NewNoteController(),
                    child: const Createoreditpage(
                      isNewNote: true,
                      readOnly: false,
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
