import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/widgets/app_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../graph_objects/graph_queries.dart';
import 'menu_details.dart';

class MealsMenu extends StatelessWidget {
  const MealsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Query(
        options: QueryOptions(document: gql(getMainMeals)),
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
                  const Icon(FluentIcons.brunch, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'No meals available',
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

          List<dynamic> mealsMenu = result.data!['Meals'];

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
            itemCount: mealsMenu.length,
            itemBuilder: (BuildContext context, int index) {
              final meal = mealsMenu[index];
              return GestureDetector(
                child: AppCard(
                  cardImage: meal['image'],
                  cardTitle: meal['name'].toString(),
                  cardSubtitle: 'UGX${meal['price']}',
                ),
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => MenuDetails(
                      menuID: meal['id'],
                      detailQuery: """
              query getMealByID(\$menuID: Int!) {
  Meals_by_pk(id: \$menuID) {
    id
    image
    name
    price
    description
  }
}
  """,
                      resultKey: 'Meals_by_pk',
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
