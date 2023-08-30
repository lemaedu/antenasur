import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.lightBlue, Colors.red],
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight)
      ),
      child: child,
    );
  }
}
