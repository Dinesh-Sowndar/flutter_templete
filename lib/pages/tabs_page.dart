import 'package:flutter/material.dart';
import 'package:flutter_templete/pages/home_page.dart';
import 'package:flutter_templete/pages/setting_page.dart';
import 'package:get/get.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var page = [
    HomePage(),
    const Center(
      child: Text("posts"),
    ),
    const Center(
      child: Text("favourite"),
    ),
    const SettingPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFFA480FF),
          unselectedItemColor: Colors.grey[800],
          showUnselectedLabels: true,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                title: Text('Home'.tr), icon: const Icon(Icons.home)),
            BottomNavigationBarItem(
              title: Text('posts'.tr),
              icon: const Icon(Icons.post_add),
            ),
            BottomNavigationBarItem(
              title: Text('favourite'.tr),
              icon: const Icon(Icons.favorite_outline),
            ),
            BottomNavigationBarItem(
              title: Text('Setting'.tr),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: page,
        ));
  }
}
