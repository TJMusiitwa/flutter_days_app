import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons, Divider;
import 'package:macos_ui/macos_ui.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('Cart')),
      children: [
        ContentArea(builder: (_, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                const Divider(
                  height: 1,
                  color: MacosColors.systemGrayColor,
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Subtotal: UGX 99,500',
                      style: MacosTheme.of(context).typography.subheadline),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('VAT: 18%',
                      style: MacosTheme.of(context).typography.subheadline),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Total: UGX 117,400',
                      style: MacosTheme.of(context)
                          .typography
                          .headline
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
                const Spacer(),
                const Divider(
                  height: 1,
                  color: MacosColors.systemGrayColor,
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: PushButton(
                        color:
                            MacosTheme.of(context).brightness == Brightness.dark
                                ? MacosColors.white
                                : MacosColors.black,
                        buttonSize: ButtonSize.large,
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Pay with'),
                              MacosIcon(
                                Icons.apple,
                                color: MacosTheme.of(context).brightness ==
                                        Brightness.dark
                                    ? MacosColors.black
                                    : MacosColors.white,
                              ),
                              const Text('Pay'),
                            ])),
                  ),
                )
              ],
            ),
          );
        })
      ],
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
                        style: MacosTheme.of(context).typography.headline),
                    const Spacer(),
                    Row(
                      children: [
                        MacosIconButton(
                            icon: const MacosIcon(CupertinoIcons.add),
                            onPressed: () {}),
                        Text(quantity!),
                        MacosIconButton(
                            icon: const MacosIcon(CupertinoIcons.minus),
                            onPressed: () {}),
                      ],
                    ),
                  ],
                ),
                Text(
                  cartExtras,
                  style: MacosTheme.of(context).typography.caption1,
                ),
                Text(cartPrice,
                    textAlign: TextAlign.justify,
                    style: MacosTheme.of(context).typography.headline),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
