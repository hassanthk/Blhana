import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF056608),
            Color(0xFF33A036), // Light Blue
            Color(0xFF52C755), // Light Blue
          ],
        ),
      ),
      child: Stack(children: [body]),
    );
  }
}
