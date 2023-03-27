import 'package:flutter/material.dart';

class Loader extends StatelessWidget {

  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
    child: CircularProgressIndicator(
        backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation(Colors.white),
        strokeWidth: 4,
    ),
  );
  }
}