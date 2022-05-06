import 'dart:math' as math;

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Card, IconButton;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart' show Card, IconButton;

class AppCard extends StatelessWidget {
  final String? cardImage, cardTitle, cardSubtitle, cardSubtitle2;
  final bool? enableLocationIcon;

  const AppCard(
      {Key? key,
      this.cardImage,
      this.cardTitle,
      this.cardSubtitle,
      this.cardSubtitle2,
      this.enableLocationIcon = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 3.0,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImageBuilder(
                  url: cardImage!,
                  builder: (image) => FittedBox(
                    fit: BoxFit.cover,
                    child: Image.file(image),
                  ),
                  placeHolder: Image.asset('assets/cjs_logo.png'),
                  errorWidget: Image.asset('assets/cjs_logo.png'),
                  imageExtensions: const ['jpg', 'png', 'jpeg'],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ColoredBox(
                  color: FluentTheme.of(context)
                      .acrylicBackgroundColor
                      .withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardTitle!,
                          style: FluentTheme.of(context).typography.subtitle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 7.0),
                        Text(
                          cardSubtitle!,
                          style: FluentTheme.of(context).typography.body,
                        ),
                        const SizedBox(height: 7.0),
                        cardSubtitle2 == null
                            ? const SizedBox.shrink()
                            : Text(
                                cardSubtitle2!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
                )),
            enableLocationIcon == true
                ? Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Transform.rotate(
                      angle: -math.pi / 25,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.location_fill),
                        iconSize: 20,
                        onPressed: () {
                          const InfoBar(
                            title: Text('Open Maps'),
                            content: Text(
                                'Will navigate to map passing the cardTitle'),
                            severity: InfoBarSeverity.info,
                          );
                          debugPrint(
                              'Will navigate to map passing the cardTitle');
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
