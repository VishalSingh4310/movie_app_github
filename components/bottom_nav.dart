import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_app/pages/home.dart';
import 'package:movies_app/pages/search.dart';
import 'package:movies_app/pages/tv_series.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({
    super.key,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    TVSeriesPage(),
    SearchPage(),
    // Text(
    //   'Profile',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: GNav(
            onTabChange: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            duration: const Duration(milliseconds: 300),
            gap: 5,
            activeColor: Theme.of(context).primaryColor,
            tabBackgroundColor: Theme.of(context).secondaryHeaderColor,
            iconSize: 22,
            padding: const EdgeInsets.all(8),
            textStyle: TextStyle(
              fontFamily: GoogleFonts.poppins.toString(),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
            tabs: const [
              GButton(
                iconColor: Colors.grey,
                icon: CupertinoIcons.flame,
                text: 'Movies',
              ),
              GButton(
                iconColor: Colors.grey,
                icon: CupertinoIcons.tv,
                text: 'TV Shows',
              ),
              GButton(
                iconColor: Colors.grey,
                icon: CupertinoIcons.search,
                text: 'Search',
              ),
              // GButton(
              //   iconColor: Colors.grey,
              //   icon: CupertinoIcons.person,
              //   text: 'Profile',
              // )
            ]),
      ),
    );
  }
}
