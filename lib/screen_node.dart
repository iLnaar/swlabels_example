
import 'package:spritewidget/spritewidget.dart' as sw;
import 'dart:ui' as ui show Size, Offset, PaintingStyle, Color;
import 'package:swlabels/swlabels.dart';
import 'package:flutter/material.dart' as mat;
import 'ball.dart';
import 'dart:math' as math show Random;

class ScreenNode extends sw.NodeWithSize {
  SWLabels swlStatus;
  SWLabels swlBalls;
  SWLabels swlTerminal;
  final balls = List<Ball>();
  final rand = math.Random();

  ScreenNode(ui.Size size) : super(size) {
    /// Initializing three objects of SWLabels.
    ///
    /// The general status will be displayed in this object.
    swlStatus = SWLabels(ui.Size(5, 1),
        maxCount: 10,
        position: ui.Offset(10, 30),
        stepY: 16,
        title: 'Status :');
    addChild(swlStatus);
    /// The status of all balls will be displayed in this object.
    swlBalls = SWLabels(size,
        maxCount: 10,
        position: ui.Offset(10, 150),
        stepY: 16,
        title: 'Ball positions :');
    addChild(swlBalls);
    /// And this object will be used as a terminal with message scrolling.
    swlTerminal = SWLabels(size,
        maxCount: 17,
        position: size.width > size.height ?
          ui.Offset(size.width - 200, 30):
          ui.Offset(10, 370),
        stepY: 16,
        title: 'Terminal :');
    addChild(swlTerminal);
    generateBalls(10);
  }

  void generateBalls(int count) {
    for (int i = 0; i < count; i++) {
      balls.add(Ball(
        x: rand.nextDouble()*size.width,
        y: rand.nextDouble()*size.height,
        radius: rand.nextDouble()*10 + 1,
        dx: rand.nextDouble()*300 - 150,
        dy: rand.nextDouble()*300 - 150,
        color: ui.Color.fromARGB(255, rand.nextInt(205)+50, rand.nextInt(205)+50, rand.nextInt(205)+50)
      ));
    }
  }

  @override
  void update(double dt) {
    // Move balls and filling all SWLabel texts
    swlStatus.print('Ball count = ${balls.length}', 'count');
    for (int i = 0; i < balls.length; ) {
      final ball = balls[i];
      ball.x += (ball.dx * dt);
      ball.y += (ball.dy * dt);
      if (ball.x <= ball.radius) {
        swlTerminal.print('Ball $i hit to the Left side');
        ball.dx = -ball.dx;
        continue;
      } else if (ball.x >= size.width - ball.radius) {
        ball.dx = -ball.dx;
        swlTerminal.print('Ball $i hit to the Right side');
        continue;
      }
      if (ball.y <= ball.radius) {
        ball.dy = -ball.dy;
        swlTerminal.print('Ball $i hit to the Top side');
        continue;
      }
      if (ball.y <= ball.radius || ball.y >= size.height - ball.radius) {
        swlTerminal.print('Ball $i hit to the Bottom side');
        ball.dy = -ball.dy;
        continue;
      }
      swlBalls.printTo('Ball $i: (${ball.x.floor()}; ${ball.y.floor()})', i);
      i++;
    }
  }

  @override
  void paint(mat.Canvas canvas) {
    final paint = mat.Paint()
      ..style = ui.PaintingStyle.fill;

    for (final ball in balls) {
      paint.color = ball.color;
      canvas.drawCircle(mat.Offset(ball.x, ball.y), ball.radius, paint);
    }

    //canvas.drawRect(mat.Rect.fromLTWH(1, 1, size.width-2, size.height-2), paint);
    //super.paint(canvas);
    //final center = mat.Offset(circleCenter.dx + ballPos.x, circleCenter.dy + ballPos.y);
    //canvas.drawCircle(center, ballRadius, mat.Paint()..color = mat.Color.fromARGB(255, 255, 255, 255));
  }
}