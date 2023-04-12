import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/widgets/mac_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../graph_objects/graph_queries.dart';
import 'menu_details.dart';

class MealsMenu extends StatelessWidget {
  const MealsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(getMainMeals)),
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
                    'No meals available',
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
                        buttonSize: ButtonSize.large,
                        onPressed: () {
                          refetch!();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text('OK')),
                  );
                });
          }
          List<dynamic> mealsMenu = result.data!['Meals'];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 50,
                crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: mealsMenu.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              final meal = mealsMenu[index];
              return MacCard(
                cardImage: meal['image'],
                cardTitle: meal['name'],
                cardSubtitle: 'UGX${meal['price']}',
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (builder) => MenuDetails(
                        menuID: meal['id'],
                        detailQuery: getMealsByID,
                        resultKey: 'Meals_by_pk',
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
