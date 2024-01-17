import 'package:agenda_pastora_app/screens/admin/appointments_admin.dart';
import 'package:agenda_pastora_app/screens/admin/home_admin.dart';
import 'package:agenda_pastora_app/screens/home.dart';
import 'package:agenda_pastora_app/screens/notifications.dart';
import 'package:agenda_pastora_app/screens/profile.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/navigation_button.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ScreenNavigatorAdminPage extends StatefulWidget {
  const ScreenNavigatorAdminPage({super.key});

  @override
  State<ScreenNavigatorAdminPage> createState() =>
      _ScreenNavigatorAdminPageState();
}

class _ScreenNavigatorAdminPageState extends State<ScreenNavigatorAdminPage> {
  int selectedIndex = 0;
  static const List<Widget> pages = [
    HomeAdminPage(),
    AppointmentsAdminPage(),
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
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationButton(
              title: 'Home',
              index: 0,
              selectedIndex: selectedIndex,
              onChangeSelected: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              icon: FeatherIcons.home,
            ),
            NavigationButton(
              title: 'Agenda',
              index: 1,
              selectedIndex: selectedIndex,
              onChangeSelected: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              icon: FeatherIcons.calendar,
            ),
            NavigationButton(
              title: 'Notificações',
              index: 2,
              selectedIndex: selectedIndex,
              onChangeSelected: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              icon: FeatherIcons.bell,
            ),
            NavigationButton(
              title: 'Perfil',
              index: 3,
              selectedIndex: selectedIndex,
              onChangeSelected: () {
                setState(() {
                  selectedIndex = 3;
                });
              },
              icon: FeatherIcons.user,
            ),
          ],
        ),
      ),
    );
  }
}
