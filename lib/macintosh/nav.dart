import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

import 'pages/cart_page.dart';
import 'pages/locations_page.dart';
import 'pages/menu_page.dart';
import 'pages/settings_page.dart';

class MacintoshNav extends StatefulWidget {
  const MacintoshNav({Key? key}) : super(key: key);

  @override
  State<MacintoshNav> createState() => _MacintoshNavState();
}

class _MacintoshNavState extends State<MacintoshNav> {
  int pageIndex = 0;

  final List<Widget> pages = <Widget>[
    CupertinoTabView(builder: (BuildContext context) => const MenuPage()),
    const LocationsPage(),
    const CartPage(),
    CupertinoTabView(builder: (BuildContext context) => const SettingsPage()),
  ];

  Color textLuminance(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? MacosColors.black
        : MacosColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      child: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      sidebar: Sidebar(
          builder: (_, controller) {
            return SidebarItems(
                currentIndex: pageIndex,
                scrollController: controller,
                onChanged: (i) => setState(() => pageIndex = i),
                items: const [
                  SidebarItem(
                    leading: MacosIcon(
                      CupertinoIcons.book_fill,
                    ),
                    label: Text('Menu'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.location_fill),
                    label: Text('Locations'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.cart),
                    label: Text('Cart'),
                  ),
                  SidebarItem(
                    leading: MacosIcon(CupertinoIcons.settings),
                    label: Text('Settings'),
                  ),
                ]);
          },
          bottom: const Padding(
            padding: EdgeInsets.all(16.0),
            child: MacosListTile(
              leading: MacosIcon(CupertinoIcons.profile_circled),
              title: Text('Javas User'),
              subtitle: Text('user@javas.com'),
            ),
          ),
          minWidth: 200),
    );
  }
}
