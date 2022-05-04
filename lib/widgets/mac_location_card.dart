import 'dart:ui';

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class FrostyBackground extends StatelessWidget {
  final Color? color;
  final double intensity;
  final Widget child;

  const FrostyBackground(
      {Key? key, this.color, this.intensity = 25, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: intensity, sigmaY: intensity),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
          child: child,
        ),
      ),
    );
  }
}

class PressableCard extends StatefulWidget {
  final VoidCallback onPressed;

  final Widget child;

  final BorderRadius borderRadius;

  final double upElevation;

  final double downElevation;

  final Color shadowColor;

  final Duration duration;

  const PressableCard(
      {Key? key,
      required this.onPressed,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.upElevation = 2,
      this.downElevation = 0,
      this.shadowColor = MacosColors.alternatingContentBackgroundColor,
      this.duration = const Duration(milliseconds: 100),
      required this.child})
      : super(key: key);
  @override
  _PressableCardState createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool cardIsDown = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cardIsDown = false;
        });
        // ignore: unnecessary_null_comparison
        if (widget.onPressed != null) {
          widget.onPressed();
        }
      },
      onTapDown: (details) => setState(() => cardIsDown = true),
      onTapCancel: () => setState(() => cardIsDown = false),
      child: AnimatedPhysicalModel(
        elevation: cardIsDown ? widget.downElevation : widget.upElevation,
        borderRadius: widget.borderRadius,
        shape: BoxShape.rectangle,
        shadowColor: widget.shadowColor,
        duration: widget.duration,
        color: MacosColors.systemGrayColor,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      ),
    );
  }
}

class MacLocationCard extends StatelessWidget {
  const MacLocationCard({
    required this.img,
    required this.location,
    required this.contact,
    Key? key,
  }) : super(key: key);
  final String img;
  final String location;
  final String? contact;

  @override
  Widget build(BuildContext context) {
    return PressableCard(
      onPressed: () {},
      child: Stack(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CachedNetworkImageBuilder(
              url: img,
              builder: (image) => FittedBox(
                fit: BoxFit.cover,
                child: Image.file(image),
              ),
              placeHolder: Image.asset('assets/cjs_logo.png'),
              errorWidget: Image.asset('assets/cjs_logo.png'),
              imageExtensions: const ['jpg', 'png', 'jpeg'],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FrostyBackground(
              color: const Color(0x90ffffff),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      location,
                      style:
                          MacosTheme.of(context).typography.headline.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                    ),
                    const SizedBox(height: 7.0),
                    Text(
                      contact!,
                      style: MacosTheme.of(context).typography.body.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
