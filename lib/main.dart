import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition_app/features/home/view/homescreen.dart';
import 'firebase_options.dart';
import 'features/canvasview/repositories/canvas_viemodel.dart';
import 'features/canvasview/view/canva_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CanvasViewModel()),
      ],

      child: MaterialApp(
        builder: EasyLoading.init(),
        initialRoute: '/',
        routes: {
          '/': (context) => Homescreen(),
          '/canvasview': (context) => CanvasView()
        },
        title: 'Flutter Demo', 
        debugShowCheckedModeBanner: false,
        home: const Homescreen(), ),
    );
  }
}
