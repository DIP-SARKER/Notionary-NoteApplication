// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/controllers/notescontroller.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/utilities/dateformator.dart';
import 'package:notes/view/screens/createoreditpage.dart';
import 'package:notes/view/widgets/floatinbutton.dart';
import 'package:notes/view/widgets/notesdrawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    'All',
    'Personal',
    'Work',
    'Ideas',
    'To-Do',
  ];
  Map<String, Color> colorMap = {
    'Personal': Colors.green.shade300,
    'Work': Colors.blue.shade400,
    'Ideas': Colors.teal.shade300,
    'To-Do': Colors.amber.shade700,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notionary',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      drawer: NotesDrawer(),
      body: Consumer<NotesController>(
        builder: (BuildContext context, NotesController value, child) {
          final List<Note> notes = value.notes;
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
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.search_normal,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: 'Search notes...',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                // Implement search functionality
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Categories
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      _selectedCategory == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color:
                                        _selectedCategory == index
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

                    // Notes Grid
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: notes.length,
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
                                                  ..note = notes[index],
                                        child: const Createoreditpage(
                                          isNewNote: false,
                                          readOnly: true,
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: _buildNoteCard(notes[index]),
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
        color: colorMap[note.category] ?? Colors.grey[300],
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

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Lottie.asset('assets/jsons/animation.json'),
        Text(
          'No notes available',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
