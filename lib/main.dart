
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart' as sw show SpriteWidget, SpriteBoxTransformMode;
import 'screen_node.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (_, orientation) {
      final screen = orientation == Orientation.landscape ?
        sw.SpriteWidget(ScreenNode(const Size(720, 400)), sw.SpriteBoxTransformMode.scaleToFit):
        sw.SpriteWidget(ScreenNode(const Size(400, 720)), sw.SpriteBoxTransformMode.scaleToFit);
      return Column(
        children: <Widget>[
          //Card(child: Text('SWLabels example'),),
          Expanded(child: screen),
          //Card(child: Text('$orientation'))
        ],
      );
    });
  }
}
