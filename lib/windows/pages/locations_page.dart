import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/graph_objects/graph_queries.dart';
import 'package:flutter_days_app/widgets/app_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Locations'),
      ),
      content: Query(
        options: QueryOptions(document: gql(getCafeLocations)),
        builder: (QueryResult? result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          //? If the query is loading, show a loading indicator.
          if (result!.isLoading) {
            return const Center(
              child: ProgressRing(),
            );
          }
//? If the query returns no data, show an empty state
          if (result.data == null) {
            return Center(
              child: Column(
                children: [
                  const Icon(FluentIcons.location, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'No locations available',
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                ],
              ),
            );
          }
//? If the query is not loading, but has an error, show the error
          if (result.exception != null) {
            return InfoBar(
              title: const Text('Error'),
              content: Text(result.exception.toString()),
              severity: InfoBarSeverity.error,
            );
          }
//? Assign the resulting data to a List variable
          List? locations = result.data!['Cafe_Locations'];

//? Create a GridView.builder widget to display the data
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 50,
                crossAxisSpacing: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: locations == null ? 0 : locations.length,
            itemBuilder: (BuildContext context, int index) {
              final location = locations![index];
              return AppCard(
                cardImage: location['location_image'],
                cardTitle: location['location_name'],
                enableLocationIcon: true,
                cardSubtitle: location['location_contact1'],
                cardSubtitle2: location['location_contact2'],
              );
            },
          );
        },
      ),
    );
  }
}
