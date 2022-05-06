import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/widgets/app_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../graph_objects/graph_queries.dart';

class DessertMenu extends StatelessWidget {
  const DessertMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Query(
        options: QueryOptions(document: gql(getDessertsMenu)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(
              child: ProgressRing(),
            );
          }

          if (result.data == null) {
            return Center(
              child: Column(
                children: [
                  const Icon(FluentIcons.cake, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'No desserts available',
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                ],
              ),
            );
          }

          if (result.exception != null) {
            return InfoBar(
              title: const Text('Error'),
              content: Text(result.exception.toString()),
              severity: InfoBarSeverity.error,
            );
          }
          List<dynamic> dessertMenu = result.data!['Desserts'];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 50,
                crossAxisSpacing: 20),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            itemCount: dessertMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final dessert = dessertMenu[index];
              return AppCard(
                cardImage: dessert['image'],
                cardTitle: dessert['name'].toString(),
                cardSubtitle: 'UGX${dessert['price']}',
              );
            },
          );
        },
      ),
    );
  }
}
