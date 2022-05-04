import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MacosScaffold(
      toolBar: ToolBar(title: Text('Locations')),
    );
  }
}
