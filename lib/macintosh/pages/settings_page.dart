import 'package:flutter/cupertino.dart';
import 'package:flutter_days_app/macintosh/pages/settings/feedback.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'settings/licenses.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text('Settings'),
      ),
      children: [
        ResizablePane(
          minSize: 180,
          startSize: 220,
          windowBreakpoint: 700,
          resizableSide: ResizableSide.right,
          builder: (_, __) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.phone),
                title: const Text('Call Us'),
                subtitle: const Text('+256393000090'),
                onClick: () => showMacosAlertDialog(
                    context: context,
                    builder: (_) => MacosAlertDialog(
                          appIcon: Image.asset(
                            'assets/cjs_logo.png',
                            width: 56,
                            height: 56,
                          ),
                          title: const Text('Call Us'),
                          message: const Text(
                              'Unfortunately you are not able to call us at this time.'),
                          primaryButton: PushButton(
                            buttonSize: ButtonSize.large,
                            child: const Text('Cancel'),
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                          ),
                        )),
              ),
              const SizedBox(height: 20),
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.mail),
                title: const Text('Email Us'),
                subtitle: const Text('info@cafejavas.co.ug'),
                onClick: () async =>
                    await launchUrl(Uri.parse('mailto:info@cafejavas.co.ug')),
              ),
              const SizedBox(height: 20),
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.news),
                title: const Text('Terms of use'),
                onClick: () async => await launchUrl(
                  Uri.parse('https://cafejavas.co.ug/user/terms'),
                ),
              ),
              const SizedBox(height: 20),
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.lock),
                title: const Text('Privacy Policy'),
                onClick: () async => await launchUrlString(
                  'https://cafejavas.co.ug/user/privacy',
                ),
              ),
              const SizedBox(height: 20),
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.bubble_left),
                title: const Text('Share your feedback'),
                onClick: () => Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => const FeedbackPage())),
              ),
              const SizedBox(height: 20),
              MacosListTile(
                leading: const MacosIcon(CupertinoIcons.info),
                title: const Text('Licenses'),
                onClick: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (_) => const MacosLicensePage())),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
