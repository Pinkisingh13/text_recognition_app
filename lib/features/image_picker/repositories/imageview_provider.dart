// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageviewProvider extends ChangeNotifier {
//   File? selectedImage;
//   String? prediction;

//   Future<String?> selectFile() async {
//     XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (file != null) {
//       selectedImage = File(file.path);
//       notifyListeners();
//     }
//   }

//   /// **Method 2: Convert Selected Image to Base64**
//   Future<String?> convertImageToBase64() async {
//     if (selectedImage == null) return null;

//     List<int> imageBytes = await selectedImage!.readAsBytes();
//     return base64Encode(imageBytes);
//   }

//   // Prediction
//   Future<String?> recognizeImage() async {
//     if (selectedImage == null) return null; // Ensure image is selected

//     final String? base64Image = await convertImageToBase64();
//     if (base64Image == null) return null;

//     final String apiKey = dotenv.env['API_KEY']!;

//     final String url =
//         "https://vision.googleapis.com/v1/images:annotate?key=$apiKey";
//   }
// }
