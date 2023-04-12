import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/windows/pages/menu/breakfast_menu.dart';
import 'package:flutter_days_app/windows/pages/menu/dessert_menu.dart';
import 'package:flutter_days_app/windows/pages/menu/drinks_menu.dart';
import 'package:flutter_days_app/windows/pages/menu/meals_menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with AutomaticKeepAliveClientMixin<MenuPage> {
  int currentTab = 0;

  final List<Widget> _pages = const [
    BreakfastMenu(),
    MealsMenu(),
    DrinksMenu(),
    DessertMenu(),
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Menu'),
      ),
      content: SizedBox(
        height: 100,
        child: TabView(
            currentIndex: currentTab,
            onChanged: (index) => setState(() => currentTab = index),
            tabs:  [
              Tab(
                  text: const Text('Breakfast Menu'),
                  icon: const Icon(FluentIcons.breakfast),
                  body: _pages[0],
                  closeIcon: null),
              Tab(
                  text: const Text('Main Meals'),
                  icon: const Icon(FluentIcons.brunch),
                  body: _pages[1],
                  closeIcon: null),
              Tab(
                  text: const Text('Drinks Menu'),
                  icon: const Icon(FluentIcons.beer_mug),
                  body: _pages[2],
                  closeIcon: null),
              Tab(
                text: const Text('Dessert Menu'),
                icon: const Icon(FluentIcons.cake),
                body: _pages[3],
                closeIcon: null,
              ),
            ],
           ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
