import 'package:flutter/material.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              IconBroken.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconBroken.chat,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconBroken.upload,
            ),
            label: 'New Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconBroken.user,
            ),
            label: 'Users',
          ),
        ],
      ),
      body: const Center(
        child: Text('text'),
      ),
    );
  }
}
