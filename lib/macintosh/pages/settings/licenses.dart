import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

class MacosLicensePage extends StatelessWidget {
  const MacosLicensePage({
    Key? key,
  }) : super(key: key);

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
    return MacosScaffold(
        toolBar: const ToolBar(
          title: Text('Licenses'),
        ),
        children: [
          ContentArea(
            builder: (_, __) => FutureBuilder<List<License>>(
              future: loadLicenses(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final licenses = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: ProgressCircle(value: null));

                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return MacosScrollbar(
                        controller: __,
                        child: ListView.separated(
                          controller: __,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          itemCount: licenses?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final license = licenses[index];
                            return MacosListTile(
                              //leading: const MacosIcon(CupertinoIcons.book),
                              title: Text(
                                license.title ?? '',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text(
                              //   license.text ?? '',
                              //   softWrap: true,
                              //   style: const TextStyle(fontSize: 18),
                              // ),
                              //onClick: () => print('Launch license viewer'),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 20),
                        ),
                      );
                    }
                }
              },
            ),
          )
        ]);
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
