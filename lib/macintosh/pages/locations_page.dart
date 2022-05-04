import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/graph_objects/graph_queries.dart';
import 'package:flutter_days_app/widgets/mac_location_card.dart';
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
                  return const Center(
                    child: Text('No Locations Found'),
                  );
                }

                if (result.exception != null) {
                  print(result.exception.toString());
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
                    return MacLocationCard(
                      img: location['location_image'],
                      location: location['location_name'],
                      contact: location['location_contact1'],
                      //contact2: '',
                    );
                  },
                );
              });
        })
      ],
    );
  }
}
