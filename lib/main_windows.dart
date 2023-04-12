import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/windows/nav.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  await initHiveForFlutter();
  final HttpLink httpLink =
      HttpLink('https://cafe-javas-flutter-app.herokuapp.com/v1/graphql');

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ),
  );
  runApp(MyApp(
    graphQLClient: client,
  ));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> graphQLClient;
  const MyApp({required this.graphQLClient, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: FluentApp(
        title: 'Flutter CJs App',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData(
            // accentColor: AccentColor('4289180570', const {
            //   '50': Color(0xfff2f4f0),
            //   '100': Color(0xffe6e9e2),
            //   '200': Color(0xffccd3c5),
            //   '300': Color(0xffb3bda8),
            //   '400': Color(0xff9aa78b),
            //   '500': Color(0xff80926d),
            //   '600': Color(0xff677458),
            //   '700': Color(0xff4d5742),
            //   '800': Color(0xff333a2c),
            //   '900': Color(0xff1a1d16)
            // }),
            accentColor: const Color(0xff044064).toAccentColor(),
            fontFamily: 'Segoe',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //typography: Typography.material2018(),
            scaffoldBackgroundColor: const Color(0xfffafafa),
            micaBackgroundColor: const Color(0xffa7b39a),
            acrylicBackgroundColor: const Color(0xffccd3c5),
            iconTheme: const IconThemeData(
              color: Color(0xff044064),
            )),
        home: const WindowsNav(),
      ),
    );
  }
}
