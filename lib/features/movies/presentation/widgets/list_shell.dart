import 'package:flutter/material.dart';

class ListShell extends StatelessWidget {
  const ListShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.20,
      child: child,
    );
  }
}
