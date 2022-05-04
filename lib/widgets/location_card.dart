import 'dart:math' as math;

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Card, IconButton;
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart' show Card, IconButton;

class LocationCard extends StatelessWidget {
  final String? img, location, contact1, contact2;

  const LocationCard(
      {Key? key, this.img, this.location, this.contact1, this.contact2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: const EdgeInsets.only(bottom: 4.0),
      duration: const Duration(milliseconds: 600),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: CachedNetworkImageBuilder(
                        url: img!,
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
                    top: 6.0,
                    right: 6.0,
                    child: Transform.rotate(
                      angle: -math.pi / 25,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.location_fill),
                        iconSize: 20,
                        //color: cjTheme.colorScheme.secondary,
                        //iconButtonMode: IconButtonMode.large,
                        onPressed: () {
                          print('Will navigate to map passing the location');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    location!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 7.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    contact1!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    contact2!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
