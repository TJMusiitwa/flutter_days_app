import 'package:fluent_ui/fluent_ui.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Cart'),
      ),
      content: Container(),
    );
  }
}
