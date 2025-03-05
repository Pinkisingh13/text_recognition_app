import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class CanvasViewModel extends ChangeNotifier {
  List<Offset?> points = [];
  String prediction = "";
  String message = "Start writing and let AI predict!";
  bool isPredictionStart = false;
  final GlobalKey _canvasKey = GlobalKey();

  //Getter
  GlobalKey get canvasKey => _canvasKey;

  //Canvas
  void draw(DragUpdateDetails details, Size canvasSize) {
    // isStartDraw = true;
    final position = details.localPosition;
    if (position.dx >= 0 &&
        position.dx <= canvasSize.width &&
        position.dy >= 0 &&
        position.dy <= canvasSize.height) {
      points.add(position);
      notifyListeners();
    }
  }

  void endDrawing() {
    points.add(null);

    notifyListeners();
  }

  void clearCanvas() {
    points.clear();
    prediction = "";
    message = "Canvas cleared! Let’s recognize something.";
    notifyListeners();
  }

  //! Convert to image
  Future<Uint8List> convertToImage() async {
    RenderRepaintBoundary? canvasScreenShot =
        _canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (canvasScreenShot == null) {
      EasyLoading.showError("Failed to capture canvas. Try Again!");
      return Uint8List(0);
    }

    ui.Image image = await canvasScreenShot.toImage(pixelRatio: 4);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      EasyLoading.showError("Error converting canvas to image.");
      return Uint8List(0);
    }
    Uint8List uint8List = byteData.buffer.asUint8List();
    return uint8List;
  }

  Future<void> recognizeText() async {
    isPredictionStart = true;
    notifyListeners();
    final String apiKey = dotenv.env['API_KEY']! ;

    final String url =
        "https://vision.googleapis.com/v1/images:annotate?key=$apiKey";

    // Convert image to base64
    final imageBytes = await convertToImage();
    String base64Image = base64Encode(imageBytes);

    final requestBody = {
      "requests": [
        {
          "image": {"content": base64Image},
          "features": [
            {"type": "DOCUMENT_TEXT_DETECTION"},
          ],
        },
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody["responses"].isNotEmpty &&
            responseBody["responses"][0].containsKey("textAnnotations")) {
          prediction =
              responseBody["responses"][0]["textAnnotations"][0]["description"];
          EasyLoading.showSuccess("Recognition successful!");
          // return prediction!.trim();
        } else {
          message = "No readable text detected. Try again.";
          EasyLoading.showError("No text found!");
          points.clear();
          prediction = "";
          if (kDebugMode) {
            print("responseBody is empty");
          }
          // return "No text detected";
        }
      } else {
        EasyLoading.showError("Failed to recognize text. Server error.");
        throw Exception("Failed to recognize text: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: ${e.toString()}");
      if (kDebugMode) {
        print("Error from catch: $e");
      }
      // return "Error: $e";
    } finally {
      isPredictionStart = false;
      notifyListeners();
    }
  }
}

//! Convert to Image

//! Code

// Future<Uint8List> convertToImage() async {

//* This function returns a Future<Uint8List>, meaning it is asynchronous and will return a list of bytes (Uint8List). The image will be stored as byte data.

//! Code
// RenderRepaintBoundary boundary =
//     _canvasKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

//* _canvasKey is a GlobalKey that refers to the widget we want to capture.

//* .currentContext gets the current BuildContext of that widget.

//* .findRenderObject() retrieves the render object (which controls how the widget is drawn on the screen).

//* We cast it as RenderRepaintBoundary because this object can be converted into an image.

//* 🔹 RenderRepaintBoundary:
//* A special Flutter widget that allows capturing its UI as an image.

//!Code
// ui.Image image = await boundary.toImage(pixelRatio: 6.0);

//* Calls .toImage(pixelRatio: 6.0) on the boundary.
//* pixelRatio: 6.0 means the image will be 6 times sharper than the default resolution.
//* The function returns a ui.Image, which is a Flutter representation of an image.

//! Code

// ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

//* Converts the ui.Image into raw bytes.
//* .toByteData(format: ui.ImageByteFormat.png) converts the image into PNG byte data.
//* ByteData? is nullable, so byteData can be null if something goes wrong.

//! Code
// if (byteData == null) {
//   return Uint8List(0);
// }

//* If byteData is null, return an empty list of bytes (Uint8List(0)) to indicate failure.
//* This prevents errors in case the image conversion fails.

//!Code
// Uint8List uint8List = byteData.buffer.asUint8List();

//* byteData.buffer gives access to the raw memory where the image is stored.
//* .asUint8List() converts it into Uint8List, which is the format used for image processing.

//!Code
// return uint8List;

//* Finally, it returns the image bytes as a Uint8List.
