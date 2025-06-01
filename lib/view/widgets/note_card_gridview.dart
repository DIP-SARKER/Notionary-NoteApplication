// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notes/controllers/newnotescontroller.dart';
import 'package:notes/utilities/colors.dart';
import 'package:notes/utilities/dateformator.dart';
import 'package:notes/view/screens/createoreditpage.dart';
import 'package:notes/view/widgets/note_card_options.dart';
import 'package:provider/provider.dart';

class NoteCardGrid extends StatefulWidget {
  final List filteredNotes;

  const NoteCardGrid({super.key, required this.filteredNotes});

  @override
  State<NoteCardGrid> createState() => _NoteCardGridState();
}

class _NoteCardGridState extends State<NoteCardGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: widget.filteredNotes.length,
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
                                  ..note = widget.filteredNotes[index],
                        child: const Createoreditpage(
                          isNewNote: false,
                          readOnly: true,
                        ),
                      ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    AppColors().colorMap[widget
                        .filteredNotes[index]
                        .category] ??
                    Colors.grey[300],
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
                                    widget.filteredNotes[index].category,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed:
                              () => NoteViewOptions.show(
                                context,
                                widget.filteredNotes[index],
                              ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Iconsax.more,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.filteredNotes[index].title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.filteredNotes[index].text,
                    style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    formatDateTime(widget.filteredNotes[index].createdAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
