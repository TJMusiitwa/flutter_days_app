import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/widgets/app_card.dart';
import 'package:flutter_days_app/windows/pages/menu/menu_details.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../graph_objects/graph_queries.dart';

class BreakfastMenu extends StatelessWidget {
  const BreakfastMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Query(
        options: QueryOptions(document: gql(getBreakfastMenu)),
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
                  const Icon(FluentIcons.breakfast, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'No breakfast available',
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
          List<dynamic> breakMenu = result.data!['Breakfast'];

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
            itemCount: breakMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final breakfast = breakMenu[index];
              return GestureDetector(
                child: AppCard(
                  cardImage: breakfast['image'],
                  cardTitle: breakfast['name'].toString(),
                  cardSubtitle: 'UGX${breakfast['price']}',
                ),
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => MenuDetails(
                      menuID: breakfast['id'],
                      detailQuery: """
              query getBreakByID(\$menuID: Int!) {
              Breakfast_by_pk(id: \$menuID) {
    id
    name
    description
    image
    price
  }
}
  """,
                      resultKey: 'Breakfast_by_pk',
                    ),
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return DrillInPageTransition(
                        animation: animation,
                        child: child,
                      );
                    },
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
