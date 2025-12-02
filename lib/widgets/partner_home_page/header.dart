import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String storeName;

  const Header({super.key, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1C1C1E),
      elevation: 10,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/avatar_placeholder.png'),
              ),
              const SizedBox(width: 12),

              /// Store Name
              Expanded(
                child: Text(
                  storeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),

              /// Notification button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.white),
              ),

              /// Profile button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
