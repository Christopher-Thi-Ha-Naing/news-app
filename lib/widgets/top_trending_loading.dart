import 'package:flutter/material.dart';

class Toptrendingloading extends StatelessWidget {
  const Toptrendingloading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      ),
    );
  }
}
