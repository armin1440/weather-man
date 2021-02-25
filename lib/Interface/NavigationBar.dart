import 'package:flutter/material.dart';
import 'OptionsScreen.dart';
import 'CitiesScreen.dart';
class NavigationBar extends StatefulWidget {
  static int pageIndex = 0;

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 16,
        backgroundColor: Colors.blue.shade300,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.location_city), label: "Cities"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Options"),
        ],
        unselectedItemColor: Colors.indigo.shade300,
        selectedItemColor: Colors.indigo.shade900,
        currentIndex: NavigationBar.pageIndex,
        showUnselectedLabels: false,
        onTap: (index) {
          NavigationBar.pageIndex = index;
          if( NavigationBar.pageIndex == 1 ){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => OptionsScreen()
                )
            );
          }
          else{
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => CitiesScreen()
                )
            );
          }
        }
    );
  }
}
