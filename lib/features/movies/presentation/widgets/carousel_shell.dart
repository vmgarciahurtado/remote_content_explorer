import 'package:flutter/material.dart';

class CarouselShell extends StatelessWidget {
  const CarouselShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.56,
      child: child,
    );
  }
}
