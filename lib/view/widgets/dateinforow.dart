import 'package:flutter/material.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:notes/utilities/dateformator.dart';

class DateInformation extends StatefulWidget {
  const DateInformation({super.key, required this.note});

  final Note? note;

  @override
  State<DateInformation> createState() => _DateInformationState();
}

class _DateInformationState extends State<DateInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Last Modified",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  formatDateTime(widget.note?.modifiedAt),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Created On",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  formatDateTime(widget.note?.createdAt),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
