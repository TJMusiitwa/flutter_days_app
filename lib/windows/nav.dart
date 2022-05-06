import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/windows/pages/cart_page.dart';
import 'package:flutter_days_app/windows/pages/favourite_page.dart';
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
      appBar: NavigationAppBar(
          leading: Image.asset(
            'assets/cjs_logo.png',
            width: 40,
            height: 40,
            color: const Color(0xff044064),
          ),
          title: const Text('Flutter CJs App'),
          automaticallyImplyLeading: false),
      pane: NavigationPane(
        selected: pageIndex,
        onChanged: (changed) => setState(() => pageIndex = changed),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 350,
        ),
        displayMode: PaneDisplayMode.compact,
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
            icon: const Icon(FluentIcons.favorite_star),
            title: const Text('Favorites'),
          ),
          PaneItem(
              icon: const Icon(FluentIcons.shopping_cart),
              title: const Text('Cart'),
              infoBadge: const InfoBadge(
                source: Text('4'),
              )),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.help),
            title: const Text('Help'),
          ),
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
          FavouritePage(),
          CartPage(),
          SettingsPage(),
          AbsorbPointer(),
          AbsorbPointer()
        ],
        transitionBuilder: (child, animation) {
          return EntrancePageTransition(child: child, animation: animation);
        },
      ),
    );
  }
}
