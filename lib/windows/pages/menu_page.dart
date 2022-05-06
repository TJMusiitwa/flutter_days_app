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

class _MenuPageState extends State<MenuPage> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Menu'),
      ),
      content: SizedBox(
        height: 100,
        child: TabView(
            currentIndex: currentTab,
            onChanged: (index) => setState(() => currentTab = index),
            tabs: const [
              Tab(
                  text: Text('Breakfast Menu'),
                  icon: Icon(FluentIcons.breakfast),
                  closeIcon: null),
              Tab(
                  text: Text('Main Meals'),
                  icon: Icon(FluentIcons.brunch),
                  closeIcon: null),
              Tab(
                  text: Text('Drinks Menu'),
                  icon: Icon(FluentIcons.beer_mug),
                  closeIcon: null),
              Tab(
                text: Text('Dessert Menu'),
                icon: Icon(FluentIcons.cake),
                closeIcon: null,
              ),
            ],
            bodies: const [
              BreakfastMenu(),
              MealsMenu(),
              DrinksMenu(),
              DessertMenu()
            ]),
      ),
    );
  }
}
