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
  late Animation<bool> animation;
  late AnimationController _controller;
  bool isSelected = false;

  Tween<bool> selectionTween = Tween(begin: false, end: true);

  double containerHeight = 100;

  @override
  void initState() {
    super.initState();
    containerHeight = 100;
    _controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);

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
            children: [
              Container(
                height: 100,
                width: 200,
                child: Stack(
                  children: [
                    AnimatedContainer(color: Colors.black, height: containerHeight, width: 100, duration: Duration(seconds: 1),),
                    CustomPaint(
                      size: Size(200, (200*0.8089887640449438).toDouble()),
                      painter: ShapePainter(true),
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){setState((){containerHeight = 1;});}, child: Text("press me"))
            ],
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  bool isSelected = false;

  ShapePainter(this.isSelected);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5;
    Path path = Path();
    if (isSelected) {
      path.moveTo(size.width*0.5010584,size.height*0.2250125);
      path.cubicTo(size.width*0.5139247,size.height*0.2250125,size.width*0.5265169,size.height*0.2237514,size.width*0.5387371,size.height*0.2213347);
      path.cubicTo(size.width*0.6957663,size.height*0.1902875,size.width*0.8385764,size.height*0.00001695417,size.width*0.9982090,size.height*0.00001695417);
      path.lineTo(size.width*0.9982090,size.height);
      path.lineTo(size.width*0.003908135,size.height);
      path.lineTo(size.width*0.003908303,size.height*0.00001695417);
      path.cubicTo(size.width*0.1635416,size.height*0.00001695417,size.width*0.3063517,size.height*0.1902875,size.width*0.4633798,size.height*0.2213347);
      path.cubicTo(size.width*0.4756000,size.height*0.2237514,size.width*0.4881933,size.height*0.2250125,size.width*0.5010584,size.height*0.2250125);
      path.close();
    } else {
      path.moveTo(44.5942, 16.2009);
      path.moveTo(88.8406,0.0012207);
      path.lineTo(88.8406,72);
      path.lineTo(0.347824,72);
      path.lineTo(0.347839,0.0012207);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
