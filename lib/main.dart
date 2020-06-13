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
  sw.SpriteWidget spriteWidget;
  ScreenNode screenNode;
  Orientation ori;

  Demo({Key key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      if (widget.ori == null || orientation != widget.ori) {
        widget.ori = orientation;
        final Size screenSize = orientation == Orientation.landscape
            ? const Size(720, 400)
            : const Size(400, 720);
        if (widget.screenNode != null) {
          widget.screenNode.delete();
        }
        widget.screenNode = ScreenNode(screenSize, orientation);
        widget.spriteWidget = sw.SpriteWidget(
            widget.screenNode, sw.SpriteBoxTransformMode.scaleToFit);
      }
      return Column(
        children: <Widget>[
          //Card(child: Text('SWLabels example'),),
          Expanded(child: widget.spriteWidget),
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
