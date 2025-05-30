import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Iconsax.add, color: Colors.white, size: 28),
    );
  }
}
