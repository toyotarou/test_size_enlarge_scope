import 'package:flutter/material.dart';

void main() {
  runApp(const MagnifierDemo());
}

class MagnifierDemo extends StatefulWidget {
  const MagnifierDemo({super.key});

  @override
  State<MagnifierDemo> createState() => _MagnifierDemoState();
}

class _MagnifierDemoState extends State<MagnifierDemo> {
  static const longSentence =
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

  Offset? magnifierPosition;

  static const magnifierWidth = 200.0;
  static const magnifierHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  setState(
                    () {
                      magnifierPosition = Offset(
                        (details.localPosition.dx - magnifierWidth / 2),
                        (details.localPosition.dy - magnifierHeight - 75),
                      );
                    },
                  );
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {
                    magnifierPosition = null;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(children: [Expanded(child: Text(longSentence))]),
                )),
            if (magnifierPosition != null)
              Positioned(
                left: magnifierPosition!.dx,
                top: magnifierPosition!.dy,
                child: const RawMagnifier(
                  decoration: MagnifierDecoration(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 3)),
                  ),
                  size: Size(magnifierWidth, magnifierHeight),
                  magnificationScale: 3,
                ),
              )
          ],
        ),
      ),
    ));
  }
}
