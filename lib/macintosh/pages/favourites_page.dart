import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      children: [
        ContentArea(
          builder: (_, __) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.heart,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                    'Favourite your favourite dishes to have them show up here.'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
