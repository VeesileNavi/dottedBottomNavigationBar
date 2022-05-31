import 'dart:developer';

import 'package:flutter/material.dart';

import 'morph.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  bool isSelected = true;

  Tween<double> selectionTween = Tween(begin: 0, end: 0.2250125);

  double containerHeight = 100;

  @override
  void initState() {
    super.initState();
    containerHeight = 100;
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation = selectionTween.animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //destory anmiation to free memory on last
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Wave Clipper Animation"),
            backgroundColor: Colors.redAccent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                child: Stack(
                  children: [
                    AnimatedContainer(color: Colors.transparent, height: containerHeight, width: 100, duration: Duration(seconds: 1),),
                    CustomPaint(
                      size: Size(200, (200*0.8089887640449438).toDouble()),
                      painter: ShapePainter(animation.value),
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){setState((){_controller.forward();});}, child: Text("press me"))
            ],
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {

  double curvePainter = 0.2250125;

  ShapePainter(this.curvePainter);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal;
    Path path = Path();

      path.moveTo(size.width*0.5010584,size.height*curvePainter/**.2250125**/);
      path.cubicTo(size.width*0.6957663,size.height*curvePainter/**.2250125**/,size.width*0.8385764,size.height*0.00001695417,size.width,size.height*0.00001695417);
      path.lineTo(size.width,size.height);
      path.lineTo(size.width*0.003908135,size.height);
      path.lineTo(size.width*0.003908303,size.height*0.00001695417);
      path.cubicTo(size.width*0.1635416,size.height*0.00001695417,size.width*0.3063517,size.height*curvePainter/**.2250125**/,size.width*0.5010584,size.height*curvePainter/**.2250125**/);
      path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
