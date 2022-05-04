import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

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
    );
  }
}
