import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Lottie.asset('assets/jsons/animation.json'),
        Text(
          'No notes available',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
