import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/graph_objects/graph_queries.dart';
import 'package:flutter_days_app/widgets/location_card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

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
          if (result!.isLoading) {
            return Center(
              child: Platform.isMacOS
                  ? const ProgressCircle()
                  : const ProgressRing(),
            );
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
            // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //   maxCrossAxisExtent: 200,
            //   mainAxisExtent: 300,
            //   mainAxisSpacing: 100,
            //   crossAxisSpacing: 50,
            //   //childAspectRatio: 1,
            // ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 50,
                crossAxisSpacing: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: locations == null ? 0 : locations.length,
            itemBuilder: (BuildContext context, int index) {
              final location = locations![index];
              return LocationCard(
                img: location['location_image'],
                location: location['location_name'],
                contact1: location['location_contact1'],
                contact2: '',
              );
            },
          );
        },
      ),
    );
  }
}
