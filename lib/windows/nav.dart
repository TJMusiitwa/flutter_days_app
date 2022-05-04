import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/windows/pages/cart_page.dart';
import 'package:flutter_days_app/windows/pages/locations_page.dart';
import 'package:flutter_days_app/windows/pages/menu_page.dart';
import 'package:flutter_days_app/windows/pages/settings_page.dart';

class WindowsNav extends StatefulWidget {
  const WindowsNav({Key? key}) : super(key: key);

  @override
  State<WindowsNav> createState() => _WindowsNavState();
}

class _WindowsNavState extends State<WindowsNav> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          title: Text('Flutter Days App'), automaticallyImplyLeading: false),
      pane: NavigationPane(
        selected: pageIndex,
        onChanged: (changed) => setState(() => pageIndex = changed),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.context_menu),
            title: const Text('Menu'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.map_pin),
            title: const Text('Locations'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.shopping_cart),
            title: const Text('Cart'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.user_window),
            title: const Text('Javas User'),
          ),
        ],
      ),
      content: NavigationBody(
        index: pageIndex,
        children: const [
          MenuPage(),
          LocationsPage(),
          CartPage(),
          SettingsPage(),
        ],
        transitionBuilder: (child, animation) {
          return EntrancePageTransition(child: child, animation: animation);
        },
      ),
    );
  }
}
