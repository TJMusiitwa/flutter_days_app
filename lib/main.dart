import 'package:flutter/material.dart' show ThemeMode, Brightness;
import 'package:flutter/widgets.dart';
import 'package:flutter_days_app/macintosh/nav.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

Future<void> main() async {
  // Cache the data from the graphql endpoint.
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://cafe-javas-flutter-app.herokuapp.com/v1/graphql',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ),
  );
  runApp(MyApp(graphQLClient: client));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.graphQLClient, Key? key}) : super(key: key);

  final ValueNotifier<GraphQLClient> graphQLClient;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: MacosApp(
        title: 'Flutter Desktop App',
        debugShowCheckedModeBanner: false,
        theme: MacosThemeData(
            primaryColor: const Color(0xffa7b39a),
            brightness: Brightness.light,
            canvasColor: const Color(0xfffafafa),
            iconTheme: const MacosIconThemeData(
              color: Color(0xff044064),
            )),
        darkTheme: MacosThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff044064),
          iconTheme: const MacosIconThemeData(
            color: Color(0xffa7b39a),
          ),
          typography: MacosTypography.white,
        ),
        themeMode: ThemeMode.system,
        home: const MacintoshNav(),
      ),
    );
  }
}
