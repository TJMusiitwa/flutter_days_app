import 'dart:math';

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:macos_ui/macos_ui.dart';

class MenuDetails extends StatelessWidget {
  const MenuDetails({
    required this.menuID,
    required this.detailQuery,
    required this.resultKey,
    Key? key,
  }) : super(key: key);

  final int menuID;
  final String detailQuery;
  final String resultKey;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(detailQuery), variables: {"menuID": menuID}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(
              child: ProgressCircle(),
            );
          }

          if (result.exception != null) {
            showMacosAlertDialog(
                context: context,
                builder: (_) {
                  return MacosAlertDialog(
                    appIcon: const Icon(CupertinoIcons.exclamationmark_triangle,
                        size: 56, color: MacosColors.systemRedColor),
                    title: const Text('Error'),
                    message: Text(
                        'Error returned the following exception: ${result.exception}'),
                    primaryButton: PushButton(
                        child: const Text('OK'),
                        buttonSize: ButtonSize.large,
                        onPressed: () {
                          refetch!();
                          Navigator.of(context, rootNavigator: true).pop();
                        }),
                  );
                });
          }

          var detail = result.data![resultKey];

          return MacosScaffold(
            toolBar: ToolBar(
              title: Text(detail['name']),
              titleWidth: 400,
              actions: [
                ToolBarIconButton(
                    label: 'Favourite',
                    icon: Icon(
                      CupertinoIcons.heart,
                      color: MacosTheme.of(context).iconTheme.color,
                    ),
                    showLabel: true),
                ToolBarIconButton(
                    label: 'Share',
                    icon: Icon(
                      CupertinoIcons.share,
                      color: MacosTheme.of(context).iconTheme.color,
                    ),
                    showLabel: true),
                ToolBarIconButton(
                    label: 'Add to Cart',
                    icon: Icon(
                      CupertinoIcons.shopping_cart,
                      color: MacosTheme.of(context).iconTheme.color,
                    ),
                    showLabel: true),
              ],
            ),
            children: [
              ContentArea(builder: (_, controller) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 450,
                        child: CachedNetworkImageBuilder(
                          url: detail['image'],
                          builder: (image) => DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: FileImage(image), fit: BoxFit.cover),
                            ),
                          ),
                          placeHolder: Image.asset('assets/cjs_logo.png'),
                          errorWidget: Image.asset('assets/cjs_logo.png'),
                          imageExtensions: const ['jpg', 'png', 'jpeg'],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Description',
                                style: MacosTheme.of(context)
                                    .typography
                                    .largeTitle),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                RatingIndicator(
                                    value: double.parse(
                                        Random().nextInt(5).toString())),
                                const SizedBox(width: 10),
                                Text('(${Random().nextInt(1000).toString()})'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 400,
                              child: Text(
                                detail['description'],
                                style:
                                    MacosTheme.of(context).typography.headline,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text('UGX${detail['price']}',
                                style: MacosTheme.of(context).typography.title2)
                          ]),
                    ],
                  ),
                );
              })
            ],
          );
        });
  }
}
