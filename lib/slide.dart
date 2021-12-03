import 'package:flutter/material.dart';

import 'home.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({Key? key}) : super(key: key);

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  late LayerLink layerLink = LayerLink();
  late OverlayEntry overlayEntry;
  late Offset indicatorOffset;

  final double indicatorWidth = 100.0;
  final double indicatorHeight = 100.0;
  final double slideHeight = 800.0;
  final double slideWidth = 400.0;

  Offset? getIndicatorOffset(Offset dragOffset){
    final double x = (dragOffset.dx - (indicatorWidth/2.0)).clamp(0.0, slideWidth - indicatorWidth);
    final double y = (slideHeight - indicatorHeight) / 3.0;
    return Offset(x,y);
  }

  void showIndicator(DragStartDetails details){
    indicatorOffset = getIndicatorOffset(details.globalPosition)!;
    overlayEntry =  OverlayEntry(
        builder: (BuildContext context){
          return Positioned(
            top:0,
            left: 0, child: SizedBox(width: indicatorWidth,
            height: indicatorHeight,
            child:  HomePage(
              offset: indicatorOffset,
              link: layerLink,

            ),),
          );
        }
    );
    Overlay.of(context)!.insert(overlayEntry);
  }
  void updateIndicator(DragUpdateDetails details) {
    indicatorOffset = getIndicatorOffset(details.localPosition)!;
    overlayEntry.markNeedsBuild();
  }

  void hideIndicator(DragEndDetails details) {
    overlayEntry.remove();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade400,
          elevation: 0,
          title: Text("CompositedTransformTarget Widget"),
        ),
        body: Center(
          child: CompositedTransformTarget(
            link: layerLink,
            child: Container(
              width: slideWidth,
              height: slideHeight,

              child: GestureDetector(
                onPanStart:showIndicator,
                onPanUpdate: updateIndicator,
                onPanEnd: hideIndicator,
              ),
            ),
          ),
        )
    );
  }
}