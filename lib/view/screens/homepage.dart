// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/view/screens/createoreditpage.dart';
import 'package:notes/view/widgets/floatinbutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;

  final List<Note> _notes = Note.notes;

  final List<String> _categories = [
    'All',
    'Personal',
    'Work',
    'Ideas',
    'To-Do',
  ];
  final Map<String, Color> categoryColors = {
    'Personal': Colors.green.shade300,
    'Work': Colors.blue.shade400,
    'Ideas': Colors.amber.shade700,
    'To-Do': Colors.teal.shade300,
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Iconsax.setting_2),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.info_circle),
              title: const Text('About'),
              onTap: () {
                // Navigate to about page
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                  const Icon(Iconsax.search_normal, color: Colors.black),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return _buildNoteCard(_notes[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: HomeFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Createoreditpage(isNewNote: true),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Container(
      decoration: BoxDecoration(
        color: categoryColors[note.category] ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    viewOptions();
                  },
                  icon: const Icon(Iconsax.more, size: 20, color: Colors.black),
                ),
              ),
            ],
          ),
          Text(
            note.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            note.content,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            note.date,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Future<dynamic> viewOptions() {
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
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Createoreditpage(
                  //       isNewNote: false,
                  //       note: note,
                  //       readOnly: true,
                  //     ),
                  //   ),
                  // );
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
                          (context) => const Createoreditpage(isNewNote: false),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Iconsax.trash),
                title: const Text('Delete'),
                onTap: () {
                  // setState(() {
                  //   _notes.remove(note);
                  // });
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
