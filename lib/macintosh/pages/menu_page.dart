import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/macintosh/pages/menu/dessert_menu.dart';
import 'package:flutter_days_app/macintosh/pages/menu/drinks_menu.dart';
import 'package:flutter_days_app/macintosh/pages/menu/meals_menu.dart';
import 'package:macos_ui/macos_ui.dart';

import 'menu/breakfast_menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with AutomaticKeepAliveClientMixin<MenuPage> {
  int _selectedViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('Menu'),
        actions: [
          ToolBarIconButton(
            label: 'Toggle Sidebar',
            icon: const MacosIcon(
              CupertinoIcons.sidebar_left,
            ),
            onPressed: () => MacosWindowScope.of(context).toggleSidebar(),
            showLabel: false,
          ),
        ],
      ),
      children: [
        ContentArea(builder: (_, __) {
          return Stack(children: [
            SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: _selectedViewIndex == 0
                    ? const BreakfastMenu()
                    : _selectedViewIndex == 1
                        ? const MealsMenu()
                        : _selectedViewIndex == 2
                            ? const DrinksMenu()
                            : const DessertMenu()),
            Positioned(
              top: 10,
              left: 50,
              right: 50,
              child: CupertinoSlidingSegmentedControl(
                children: const {
                  0: Text('Breakfast Menu'),
                  1: Text('Meals Menu'),
                  2: Text('Drinks Menu'),
                  3: Text('Desserts Menu'),
                },
                groupValue: _selectedViewIndex,
                thumbColor: MacosTheme.of(context).primaryColor,
                onValueChanged: (value) =>
                    setState(() => _selectedViewIndex = value as int),
              ),
            )
          ]);
        })
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
