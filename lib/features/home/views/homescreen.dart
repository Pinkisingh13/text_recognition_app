import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose the option")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/canvasview');
            },
            child: Text("Play with Canvas"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/imageview');
            },
            child: Text("Use Device Image"),
          ),
        ],
      ),
    );
  }
}
