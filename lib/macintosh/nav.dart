import 'package:flutter/cupertino.dart' hide OverlayVisibilityMode;
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

  // Color textLuminance(Color backgroundColor) {
  //   return backgroundColor.computeLuminance() > 0.5
  //       ? MacosColors.black
  //       : MacosColors.white;
  // }

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
          bottom: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MacosListTile(
              leading: const MacosIcon(CupertinoIcons.profile_circled),
              title: const Text('Javas User'),
              subtitle: const Text('user@javas.com'),
              onClick: () {
                showMacosAlertDialog(
                  context: context,
                  builder: (_) => MacosAlertDialog(
                    appIcon: const MacosIcon(
                      CupertinoIcons.profile_circled,
                      size: 56,
                    ),
                    title: const Text('Sign in to your account'),
                    message: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(height: 8),
                        MacosTextField(
                          placeholder: 'Email',
                          autofillHints: [AutofillHints.email],
                          clearButtonMode: OverlayVisibilityMode.editing,
                        ),
                        SizedBox(height: 10),
                        MacosTextField(
                          placeholder: 'Password',
                          autofillHints: [AutofillHints.password],
                          clearButtonMode: OverlayVisibilityMode.editing,
                        ),
                      ],
                    ),
                    horizontalActions: false,
                    primaryButton: PushButton(
                        child: const Text('Sign In'),
                        buttonSize: ButtonSize.large,
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop()),
                    secondaryButton: PushButton(
                        child: const Text('Cancel'),
                        buttonSize: ButtonSize.large,
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop()),
                  ),
                );
              },
            ),
          ),
          minWidth: 200),
    );
  }
}
