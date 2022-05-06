import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_days_app/windows/pages/settings/feedback.dart';
import 'package:flutter_days_app/windows/pages/settings/license.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Settings'),
      ),
      content: ListView(children: [
        TappableListTile(
          leading: const Icon(FluentIcons.phone),
          title: const Text('Call Us'),
          subtitle: const Text('+25630000909'),
          trailing: const Icon(FluentIcons.chevron_right),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => ContentDialog(
                      title: const Text('Call Us'),
                      content: const Text(
                          'Unfortunately you are not able to call us at this time.'),
                      actions: [
                        FilledButton(
                          child: const Text('Close'),
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                        ),
                      ],
                    ));
          },
        ),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(FluentIcons.mail),
          title: Text('Email Us'),
          subtitle: Text('info@cafejavas.co.ug'),
        ),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(FluentIcons.clipboard_list),
          title: Text('Terms and Conditions'),
        ),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(FluentIcons.lock),
          title: Text('Privacy Policy'),
        ),
        const SizedBox(height: 10),
        TappableListTile(
          leading: const Icon(FluentIcons.feedback),
          title: const Text('Share your Feedback'),
          onTap: () => Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => const FeedbackPage(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return DrillInPageTransition(
                animation: animation,
                child: child,
              );
            },
          )),
        ),
        const SizedBox(height: 10),
        TappableListTile(
          leading: const Icon(FluentIcons.info),
          title: const Text('Licenses'),
          onTap: () => Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LicensePage(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return DrillInPageTransition(
                animation: animation,
                child: child,
              );
            },
          )),
        ),
      ]),
    );
  }
}
