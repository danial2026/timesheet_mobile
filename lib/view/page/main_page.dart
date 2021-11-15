import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timesheet_flutter_app/view/page/home_page.dart';
import 'package:timesheet_flutter_app/view/page/spreadsheet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 2;
  List<Widget> pages = <Widget>[
    SpreadsheetPage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          onTap: (int index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/images/sheet.svg',
                  height: 25,
                  width: 25,
                  color: Colors.blueAccent,
                ),
                icon: SvgPicture.asset(
                  'assets/images/sheet.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey,
                ),
                label: 'Sheets'),
            const BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.search, color: Colors.blueAccent, size: 25),
                icon: Icon(Icons.search, color: Colors.grey, size: 20),
                label: 'Search'),
            const BottomNavigationBarItem(
                activeIcon:
                    Icon(Icons.home, color: Colors.blueAccent, size: 25),
                icon: Icon(Icons.home, color: Colors.grey, size: 20),
                label: 'Home'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/images/jira-1.svg',
                  height: 25,
                  width: 25,
                  color: Colors.blueAccent,
                ),
                icon: SvgPicture.asset(
                  'assets/images/jira-1.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey,
                ),
                label: 'Jira'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/images/todo-list.svg',
                  height: 25,
                  width: 25,
                  color: Colors.blueAccent,
                ),
                icon: SvgPicture.asset(
                  'assets/images/todo-list.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey,
                ),
                label: 'Todoist'),
          ],
        ),
      );
}
