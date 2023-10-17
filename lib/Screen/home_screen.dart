import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/custom_icon.dart';
import 'package:tiktok_clone/widgets/editpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (idx) {
            setState(() {
              pageIdx = idx;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white,
          currentIndex: pageIdx,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  size: 30,
                ),
                label: 'Chat'),
            BottomNavigationBarItem(icon: CustomIcon(), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mail,
                  size: 30,
                ),
                label: 'Mail'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  size: 30,
                ),
                label: 'Profile'),
          ]),
      body: pages[pageIdx],
    );
  }
}
