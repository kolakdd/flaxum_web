import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color.fromARGB(255, 0, 129, 50),
        size: 200,
      ),
    ));
  }
}
