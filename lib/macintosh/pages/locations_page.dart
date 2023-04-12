import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/graph_objects/graph_queries.dart';
import 'package:flutter_days_app/widgets/mac_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('Locations')),
      children: [
        ContentArea(builder: (context, scrollController) {
          return Query(
              options: QueryOptions(document: gql(getCafeLocations)),
              builder: (QueryResult? result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result!.isLoading) {
                  return const Center(child: ProgressCircle());
                }

                if (result.data == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.location_fill, size: 64),
                      SizedBox(height: 10),
                      Text('No Locations Found'),
                    ],
                  );
                }

                if (result.exception != null) {
                  showMacosAlertDialog(
                      context: context,
                      builder: (_) {
                        return MacosAlertDialog(
                          appIcon: const Icon(
                              CupertinoIcons.exclamationmark_triangle,
                              size: 56,
                              color: MacosColors.systemRedColor),
                          title: const Text('Error'),
                          message: Text(
                              'Error returned the following exception: ${result.exception}'),
                          primaryButton: PushButton(
                              buttonSize: ButtonSize.large,
                              onPressed: () {
                                refetch!();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Text('OK')),
                        );
                      });
                }

                List? locations = result.data!['Cafe_Locations'];

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: locations == null ? 0 : locations.length,
                  itemBuilder: (BuildContext context, int index) {
                    final location = locations![index];
                    return MacCard(
                      cardImage: location['location_image'],
                      cardTitle: location['location_name'],
                      cardSubtitle: location['location_contact1'],
                      //contact2: '',
                      onPressed: () {},
                    );
                  },
                );
              });
        })
      ],
    );
  }
}
