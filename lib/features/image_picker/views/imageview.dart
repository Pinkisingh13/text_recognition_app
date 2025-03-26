// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:text_recognition_app/features/image_picker/repositories/imageview_provider.dart';

// class ImageView extends StatelessWidget {
//   const ImageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final imageviewProvider = context.watch<ImageviewProvider>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pick Image", style: TextStyle(color: Colors.white)),
//         backgroundColor: Color(0xff2D336B),
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Colors.white,
//             size: 17,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           if (imageviewProvider.selectedImage != null)
//              Container(
//               margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//               constraints: BoxConstraints(),
//               decoration: BoxDecoration(color: Colors.black),
//                 height: 300,
//                 width: 300,
//                 child: Image.file(
//                   imageviewProvider.selectedImage!,
//                   fit: BoxFit.contain,
//                 ),
//               ),
            

//           ElevatedButton(
//             onPressed: imageviewProvider.selectFile,
//             child: const Text('Select file'),
//           ),
//           ElevatedButton(
//             onPressed: (){},
//             child: const Text('Predict'),
//           ),
//         ],
//       ),
//     );
//   }
// }
