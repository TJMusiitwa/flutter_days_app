import 'package:flutter/material.dart';
import 'package:flutter_days_app/macintosh/nav.dart';
import 'package:macos_ui/macos_ui.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  // // Add this your main method.
  // // used to show a webview title bar.
  // if (runWebViewTitleBarWidget(args)) {
  //   return;
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'Flutter Days App',
      theme: MacosThemeData(
          primaryColor: const Color(0xffa7b39a),
          brightness: Brightness.light,
          canvasColor: const Color(0xfffafafa),
          iconTheme: const MacosIconThemeData(
            color: Color(0xff044064),
          )),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const MacintoshNav(),
    );
  }
}
