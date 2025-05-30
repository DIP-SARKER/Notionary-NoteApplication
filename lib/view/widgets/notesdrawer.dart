import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotesDrawer extends StatelessWidget {
  const NotesDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}