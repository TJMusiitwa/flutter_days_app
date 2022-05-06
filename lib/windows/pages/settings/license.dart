import 'package:fluent_ui/fluent_ui.dart' hide ListTile;
import 'package:flutter/foundation.dart';

class LicensePage extends StatelessWidget {
  const LicensePage({Key? key}) : super(key: key);

  Future<List<License>> loadLicenses() async =>
      LicenseRegistry.licenses.asyncMap<License>((license) async {
        final title = license.packages.join('\n');
        final text = license.paragraphs
            .map<String>((paragraph) => paragraph.text)
            .join('\n\n');

        return License(title, text);
      }).toList();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Licenses'),
      ),
      content: FutureBuilder<List<License>>(
        future: loadLicenses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final licenses = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: ProgressRing(value: null));

            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: licenses?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final license = licenses[index];
                    return Expander(
                        header: Text(
                          license.title ?? '',
                          style: FluentTheme.of(context).typography.bodyStrong,
                        ),
                        content: Text(
                          license.text ?? '',
                          style: FluentTheme.of(context).typography.body,
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 30),
                );
              }
          }
        },
      ),
    );
  }
}

class License {
  late String title;
  late String text;

  License(this.title, this.text);

  License.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }
}
