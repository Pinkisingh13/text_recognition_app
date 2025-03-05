// import 'dart:ui';

// import 'package:flutter/material.dart';

// abstract class CanvasFunctions{
//      draw(DragUpdateDetails details, Size canvasSize);
//      endDrawing();
//      clearCanvas();
// }

// class CanvasRepo implements CanvasFunctions{
//   @override
//   clearCanvas() {
//     //  points.clear();
//     // prediction = "";
//     // notifyListeners();
//   }

//   @override
//   draw(DragUpdateDetails details, Size canvasSize) {
//     final position = details.localPosition;
//     if (position.dx >= 0 &&
//         position.dx <= canvasSize.width &&
//         position.dy >= 0 &&
//         position.dy <= canvasSize.height) {
//       points.add(position);
//       notifyListeners();
//     }
//   }

//   @override
//   endDrawing() {
//     points.add(null);
//     notifyListeners();
//   }

// }
