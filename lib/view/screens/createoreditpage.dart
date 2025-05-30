import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class Createoreditpage extends StatefulWidget {
  const Createoreditpage({super.key});

  @override
  State<Createoreditpage> createState() => _CreateoreditpageState();
}

class _CreateoreditpageState extends State<Createoreditpage> {
  String formatDateTime([DateTime? dateTime]) {
    DateTime dt = (dateTime ?? DateTime.now()).toLocal();
    return DateFormat('dd MMMM yyyy, hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Save note logic here
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.save_2, color: Colors.black),
            onPressed: () {
              // Save note logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                fillColor: Colors.transparent,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last Modified",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(formatDateTime(), style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Created",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    formatDateTime(
                      DateTime.now().subtract(
                        const Duration(days: 5, hours: 3, minutes: 27),
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Category",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.add_square, size: 16),
                  ),
                  const SizedBox(width: 150),
                  Text("General", style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            TextField(
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Notes Description Goes Here......',
                border: InputBorder.none,
                fillColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
