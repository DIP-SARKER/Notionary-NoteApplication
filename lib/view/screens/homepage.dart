// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/utilities/catagoriesoption.dart';
import 'package:notes/utilities/colors.dart';
import 'package:notes/utilities/dateformator.dart';
import 'package:notes/view/screens/createoreditpage.dart';
import 'package:notes/view/widgets/floatinbutton.dart';
import 'package:notes/view/widgets/no_notes_view.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notionary',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          selectedCategory == 0
              ? IconButton(
                icon: const Icon(Iconsax.filter),
                onPressed:
                    () => setState(() {
                      isFilterApplied = !isFilterApplied;
                    }),
              )
              : const SizedBox.shrink(),
          const SizedBox(width: 2),
        ],
      ),
      drawer: NotesDrawer(),
      body: Consumer<NotesController>(
        builder: (BuildContext context, NotesController value, child) {
          final List<Note> notes = value.notes;
          // Compute filteredNotes dynamically
          final List<Note> filteredNotes =
              selectedCategory == 0
                  ? (isFilterApplied
                      ? (notes
                        ..sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt)))
                      : (notes
                        ..sort((b, a) => b.createdAt.compareTo(a.createdAt))))
                  : notes
                      .where(
                        (note) =>
                            note.category ==
                            Catagories().categories[selectedCategory],
                      )
                      .toList();

          return notes.isEmpty
              ? NoNotes()
              : Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBox(),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Catagories().categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selectedCategory == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  Catagories().categories[index],
                                  style: TextStyle(
                                    color:
                                        selectedCategory == index
                                            ? Colors.white
                                            : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: filteredNotes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChangeNotifierProvider(
                                        create:
                                            (BuildContext context) =>
                                                NewNoteController()
                                                  ..note = filteredNotes[index],
                                        child: const Createoreditpage(
                                          isNewNote: false,
                                          readOnly: true,
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: _buildNoteCard(filteredNotes[index]),
                          );
                        },
                      ),
                    ),
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

  Widget _buildNoteCard(Note note) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors().colorMap[note.category] ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            note.category,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    viewOptions(note);
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(Iconsax.more, size: 20, color: Colors.black),
                ),
              ),
            ],
          ),
          Text(
            note.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            note.text,
            style: TextStyle(fontSize: 15, color: Colors.grey[900]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            formatDateTime(note.createdAt),
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Future<dynamic> viewOptions(Note note) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
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
                          (context) => ChangeNotifierProvider(
                            create:
                                (BuildContext context) =>
                                    NewNoteController()..note = note,
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
                onTap: () {
                  Provider.of<NotesController>(
                    context,
                    listen: false,
                  ).removeNote(note);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
