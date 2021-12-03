import 'package:compositetransformtarget/star_clipper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final LayerLink? link;
  final Offset? offset;
  const HomePage({Key? key, this.link,  this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CompositedTransformFollower(
      offset: offset!,
      link: link!,
      child: ClipPath(
        clipper: StarClipper(6),
        child: Container(
          color: Colors.pink.shade300,
        ),
      ),
    );
  }
}





