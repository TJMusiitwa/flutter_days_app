import 'dart:math';

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MenuDetails extends StatelessWidget {
  MenuDetails({
    required this.menuID,
    required this.detailQuery,
    required this.resultKey,
    Key? key,
  }) : super(key: key);

  final int menuID;
  final String detailQuery;
  final String resultKey;

  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(detailQuery), variables: {"menuID": menuID}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(
              child: ProgressRing(),
            );
          }

          if (result.exception != null) {
            return InfoBar(
              title: const Text('Error'),
              content: Text(result.exception.toString()),
              severity: InfoBarSeverity.error,
            );
          }

          var detail = result.data![resultKey];

          return ScaffoldPage(
            header: PageHeader(
              leading: IconButton(
                  icon: const Icon(FluentIcons.back),
                  iconButtonMode: IconButtonMode.large,
                  onPressed: () => Navigator.of(context).pop()),
              title: Text(detail['name']),
              commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                overflowBehavior: CommandBarOverflowBehavior.noWrap,
                //compactBreakpointWidth: 700,
                primaryItems: [
                  CommandBarButton(
                      icon: const Icon(FluentIcons.favorite_star),
                      label: const Text('Favourite'),
                      onPressed: () {}),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.share),
                    label: const Text('Share'),
                    onPressed: () {},
                  ),
                  CommandBarButton(
                    icon: const Icon(FluentIcons.shopping_cart),
                    label: const Text('Add to Cart'),
                    onPressed: () {},
                  )
                ],
              ),
            ),

            //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            content: Scrollbar(
              controller: _controller,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SizedBox(width: 50),
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
                              style:
                                  FluentTheme.of(context).typography.subtitle),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              RatingBar(
                                  rating: double.parse(
                                      Random().nextInt(5).toString())),
                              const SizedBox(width: 10),
                              Text('(${Random().nextInt(1000).toString()})'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 400,
                            child: Text(detail['description'],
                                style: FluentTheme.of(context).typography.body),
                          ),
                          const SizedBox(height: 20),
                          Text('UGX${detail['price']}',
                              style:
                                  FluentTheme.of(context).typography.bodyStrong)
                        ])
                  ],
                ),
              ),
            ),
          );
        });
  }
}
