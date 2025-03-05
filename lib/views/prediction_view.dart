import 'package:flutter/material.dart';

class PredictionView extends StatelessWidget {
  const PredictionView({super.key});

  @override
  Widget build(BuildContext context) {
    // final canvasVM = context.watch<CanvasViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Prediction')),
      body: Center(
        child: Text(
          // 'Prediction: ${canvasVM.prediction ?? 'N/A'}',
          "",

          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
