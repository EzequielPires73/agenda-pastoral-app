import 'package:agenda_pastora_app/screens/home.dart';
import 'package:agenda_pastora_app/screens/notifications.dart';
import 'package:agenda_pastora_app/screens/profile.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ScreenNavigatorPage extends StatefulWidget {
  const ScreenNavigatorPage({super.key});

  @override
  State<ScreenNavigatorPage> createState() => _ScreenNavigatorPageState();
}

class _ScreenNavigatorPageState extends State<ScreenNavigatorPage> {
  int selectedIndex = 0;
  static const List<Widget> pages = [
    HomePage(),
    NotificationsPage(),
    ProfilePage()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: ColorPalette.gray1,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.home,
                    color: selectedIndex == 0
                        ? ColorPalette.primary
                        : ColorPalette.gray7,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                        color: selectedIndex == 0
                            ? ColorPalette.primary
                            : ColorPalette.gray7,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.bell,
                    color: selectedIndex == 1
                        ? ColorPalette.primary
                        : ColorPalette.gray7,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Notificações',
                    style: TextStyle(
                        color: selectedIndex == 1
                            ? ColorPalette.primary
                            : ColorPalette.gray7,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.user,
                    color: selectedIndex == 2
                        ? ColorPalette.primary
                        : ColorPalette.gray7,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Perfil',
                    style: TextStyle(
                        color: selectedIndex == 2
                            ? ColorPalette.primary
                            : ColorPalette.gray7,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
