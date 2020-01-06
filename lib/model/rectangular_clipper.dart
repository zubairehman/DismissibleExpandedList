import 'package:flutter/material.dart';

class RectangularClipper extends CustomClipper<Path> {
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  RectangularClipper({
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  getClip(Size size) {
    var path;

    if (topLeft) {
      path = _clipForTopLeft(size);
    } else if (bottomLeft) {
      path = _clipForBottomLeft(size);
    } else if (bottomRight) {
      path = _clipForBottomRight(size);
    } else if (topLeft) {
      path = _clipForTopLeft(size);
    }
    return path;
  }

  Path _clipForTopLeft(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  Path _clipForBottomLeft(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  Path _clipForBottomRight(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}