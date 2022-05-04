import 'package:fluent_ui/fluent_ui.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Menu'),
      ),
      content: Container(),
    );
  }
}
