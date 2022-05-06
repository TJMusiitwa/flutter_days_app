import 'package:fluent_ui/fluent_ui.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Cart'),
      ),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CartListTile(
                  cartMain: 'CJ’S House Breakfast',
                  cartExtras: '1 x Extra Sausage, 1 x Egg, 1 x Bacon',
                  cartPrice: 'Ugx. 25,000',
                ),
                const SizedBox(height: 20),
                const CartListTile(
                  cartMain: 'Fish Fingers & Chips',
                  cartExtras: '',
                  cartPrice: 'Ugx. 34,500',
                ),
                const SizedBox(height: 20),
                const CartListTile(
                  cartMain: 'Passion Fruit Nojito',
                  cartExtras: '',
                  cartPrice: 'Ugx. 16,500',
                  quantity: '2',
                ),
                const SizedBox(height: 20),
                const CartListTile(
                  cartMain: 'Mint Scoop Ice Cream',
                  cartExtras: '',
                  cartPrice: 'Ugx. 7,000',
                  quantity: '1',
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Subtotal: UGX 99,500',
                      style: FluentTheme.of(context).typography.body),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('VAT: 18%',
                      style: FluentTheme.of(context).typography.bodyStrong),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Total: UGX 117,400',
                      style: FluentTheme.of(context).typography.bodyLarge),
                ]),
                const Spacer(),
                const Divider(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                      child: SizedBox(
                    width: 200,
                    child: FilledButton(
                      child: const Text('Checkout'),
                      onPressed: () {},
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartListTile extends StatelessWidget {
  const CartListTile({
    required this.cartMain,
    required this.cartExtras,
    required this.cartPrice,
    this.quantity = '1',
    Key? key,
  }) : super(key: key);

  final String cartMain;
  final String cartExtras;
  final String cartPrice;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            'assets/cjs_logo.png',
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(cartMain,
                        style: FluentTheme.of(context).typography.bodyLarge),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(FluentIcons.calculator_addition),
                            onPressed: () {}),
                        Text(quantity!),
                        IconButton(
                            icon: const Icon(FluentIcons.calculator_subtract),
                            onPressed: () {}),
                      ],
                    ),
                  ],
                ),
                Text(
                  cartExtras,
                  style: FluentTheme.of(context).typography.caption,
                ),
                Text(cartPrice,
                    textAlign: TextAlign.justify,
                    style: FluentTheme.of(context).typography.bodyStrong),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
