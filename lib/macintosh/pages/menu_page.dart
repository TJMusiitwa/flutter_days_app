import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedViewIndex = 0;
  @override
  Widget build(BuildContext context) {
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
          return Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
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
              ),
            ],
          );
        })
      ],
    );
  }
}
