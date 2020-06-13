import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart' as sw
    show SpriteWidget, SpriteBoxTransformMode;
import 'screen_node.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {

  Demo({Key key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  sw.SpriteWidget spriteWidget;
  ScreenNode screenNode;
  Orientation ori;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      if (orientation != ori) {
        ori = orientation;
        final Size screenSize = orientation == Orientation.landscape
            ? const Size(720, 400)
            : const Size(400, 720);
        if (screenNode != null) {
          screenNode.delete();
        }
        screenNode = ScreenNode(screenSize, orientation);
        spriteWidget = sw.SpriteWidget(
            screenNode, sw.SpriteBoxTransformMode.scaleToFit);
      }
      return Column(
        children: <Widget>[
          //Card(child: Text('SWLabels example'),),
          Expanded(child: spriteWidget),
          //Card(child: Text('$orientation'))
        ],
      );
    });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}
