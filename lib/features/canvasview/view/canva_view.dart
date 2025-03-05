import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition_app/features/canvasview/repositories/canvas_viemodel.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CanvasView extends StatelessWidget {
  const CanvasView({super.key});

  @override
  Widget build(BuildContext context) {
    final canvasProvider = context.watch<CanvasViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Canvas", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff2D336B),
      ),
      body: Column(
        children: [
          CanvasBoard(),

          SizedBox(height: 50),

          canvasProvider.isPredictionStart
              ? loadingAnimation()
              : AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                      canvasProvider.prediction.isNotEmpty == true
                          ? canvasProvider.prediction
                          : canvasProvider.message,
                      key: ValueKey(canvasProvider.prediction),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: canvasProvider.prediction.isNotEmpty ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color:
                            canvasProvider.prediction.isNotEmpty == true
                                ? Colors.blueAccent
                                : Colors.black87,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.grey.shade300,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fade(duration: 600.ms)
                    .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1)),
              ),

          // : Center(
          //   child: Text(
          //     textAlign: TextAlign.center,
          //     canvasProvider.prediction?.isNotEmpty == true
          //         ? canvasProvider.prediction!
          //         : canvasProvider.message,
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          SizedBox(height: 30),

          ButtonWidget(),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final canvasProvider = context.watch<CanvasViewModel>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     canvasProvider.clearCanvas();
        //   },
        //   child: Text("clear"),
        // ),
        _buildButton(
          text: "Clear",
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: canvasProvider.clearCanvas,
          isPredictionStart: canvasProvider.isPredictionStart
        ),

        SizedBox(width: 20),

        //Extract
        // ElevatedButton(
        //   onPressed: () => canvasProvider.isPredictionStart ? null : canvasProvider.recognizeText(),
        //   child: Text("Predict"),
        // ),
        _buildButton(
          text: "Predict",
          color: Color(0xff7886C7),
          icon: Icons.auto_fix_high,
          onTap: () {
            if (canvasProvider.points.isEmpty ||
                canvasProvider.points.every((point) => point == null)) {
              EasyLoading.showToast("Please start writing");
              null;
            } else {
              canvasProvider.recognizeText();
            }
          },
          isPredictionStart: canvasProvider.isPredictionStart,
        ),
      ],
    );
  }
}

Widget _buildButton({
  required String text,
  required Color color,
  required IconData icon,
  required VoidCallback onTap,
  bool? isPredictionStart,
}) {
  return InkWell(
    splashColor: Colors.white,
    
    onTap: (isPredictionStart ?? false) ? null : onTap,
    borderRadius: BorderRadius.circular(20),
    child:
        Container(
          width: 150,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ).animate().scale(duration: 300.ms).then(delay: 100.ms).shake(),
  );
}

class CanvasBoard extends StatelessWidget {
  const CanvasBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final canvasProvider = context.watch<CanvasViewModel>();
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Color(0xffFFF2F2), blurRadius: 2)],
      ),
      height: 400,
      width: 400,
      child: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: DotCustomBackgroundPaint()),
          LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                onPanUpdate: (details) {
                  canvasProvider.draw(details, constraints.biggest);
                },
                onPanEnd: (details) => canvasProvider.endDrawing(),

                child: SizedBox.expand(
                  child: RepaintBoundary(
                    key: canvasProvider.canvasKey,
                    child: CustomPaint(
                      painter: CustomPainterWidget(
                        points: canvasProvider.points,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DotCustomBackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint dotPaint =
        Paint()
          ..color = const Color.fromARGB(255, 220, 220, 220)
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill;

    const double spacing = 30.0;
    for (double i = 25; i <= size.width; i += spacing) {
      for (double j = 25; j <= size.height; j += spacing) {
        // print(Offset(i, j));
        canvas.drawCircle(Offset(i, j), 1.3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomPainterWidget extends CustomPainter {
  CustomPainterWidget({required this.points});

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Color(0xff2D336B)
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0;

    for (var i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainterWidget oldDelegate){
    
    // Problem: shouldRepaint always returns true in CustomPainterWidget.
// Solution: Compare previous points for equality:

    //  return !listEquals(oldDelegate.points, points);
    return true;
  }
}

// Loading animation
TweenAnimationBuilder loadingAnimation() {
  return TweenAnimationBuilder<double>(
    tween: Tween<double>(begin: 0, end: 1),
    duration: Duration(seconds: 5),
    builder: (context, value, child) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background Bar
          Container(
            width: 300,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Animated Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 300 * value,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 19, 0, 187),
                    Colors.lightBlueAccent,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Percentage Text
          Positioned.fill(
            child: Center(
              child: Text(
                "${(value * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
