import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/widgets/mac_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../graph_objects/graph_queries.dart';

class DrinksMenu extends StatelessWidget {
  const DrinksMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getDrinks)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(
              child: ProgressCircle(),
            );
          }

          if (result.data == null) {
            return Center(
              child: Column(
                children: [
                  const Icon(CupertinoIcons.exclamationmark, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'No drinks available',
                    style: MacosTheme.of(context).typography.subheadline,
                  ),
                ],
              ),
            );
          }

          if (result.exception != null) {
            showMacosAlertDialog(
                context: context,
                builder: (_) {
                  return MacosAlertDialog(
                    appIcon: const Icon(CupertinoIcons.exclamationmark_triangle,
                        size: 56, color: MacosColors.systemRedColor),
                    title: const Text('Error'),
                    message: Text(
                        'Error returned the following exception: ${result.exception}'),
                    primaryButton: PushButton(
                        child: const Text('OK'),
                        buttonSize: ButtonSize.large,
                        onPressed: () {
                          refetch!();
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  );
                });
          }
          List<dynamic> drinksMenu = result.data!['Drinks'];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 50,
                crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: drinksMenu.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              final drink = drinksMenu[index];
              return MacCard(
                cardImage: drink['image'],
                cardTitle: drink['name'],
                cardSubtitle: 'UGX${drink['price']}',
                onPressed: () {},
              );
            },
          );
        });
  }
}
