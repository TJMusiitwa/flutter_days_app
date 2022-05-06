import 'package:fluent_ui/fluent_ui.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Favourites'),
      ),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(FluentIcons.add_favorite, size: 60),
            const SizedBox(height: 20),
            Text(
              'Favourite you meals and have them show up here',
              style: FluentTheme.of(context).typography.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
