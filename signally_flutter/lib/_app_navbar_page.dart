import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signally/pages/user/announcement_page.dart';
import 'package:signally/pages/user/signals_page.dart';
import 'package:signally/utils_constants/app_colors.dart';

import '../../models_providers/navbar_provider.dart';
import 'pages/user/my_account_page.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  _NavbarPageState createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  @override
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<NavbarProvider>(context);
    final selectedIndex = appProvider.selectedPageIndex;

    return Scaffold(
      body: pages[appProvider.selectedPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF29282E), Color(0xFF29282E)])),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(color: Colors.white),
            selectedItemColor: appYellow,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(height: 1.5, fontSize: 12, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(height: 1.5, fontSize: 11, fontWeight: FontWeight.w500),
            type: BottomNavigationBarType.fixed,
            currentIndex: appProvider.selectedPageIndex,
            onTap: (v) {
              appProvider.selectedPageIndex = v;
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Image.asset(selectedIndex == 0 ? 'assets/images/icon_home_selected.png' : 'assets/images/icon_home_unselected.png', height: 28),
              ),
              BottomNavigationBarItem(
                label: 'Signals',
                icon: Image.asset(selectedIndex == 1 ? 'assets/images/icon_signals_selected.png' : 'assets/images/icon_signals_unselected.png',
                    height: 28),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Image.asset(selectedIndex == 2 ? 'assets/images/icon_profile_selected.png' : 'assets/images/icon_profile_unselected.png',
                    height: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }

/* ----------------------------- NOTE UserPages ----------------------------- */

  List<Widget> pages = [
    AnnouncementPage(),
    SignalsPage(),
    MyAccountPage(),
  ];
}
