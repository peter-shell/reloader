import 'package:flutter/material.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreenCustom extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreenCustom({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreenCustom> createState() =>
      _DisplayPictureScreenCustomState();
}

final controller = TransformationController();

@override
void initState() {
  //final controller = TransformationController();
  controller.value = Matrix4.identity() * 0.5;
  initState();
}

@override
void dispose() {
  controller.dispose();
  dispose();
}

var myStack = <Widget>[]; // used to dynamically insert widgets into stack
GlobalKey key = GlobalKey();

class _DisplayPictureScreenCustomState
    extends State<DisplayPictureScreenCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Measure Your Group')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.

        body: Container(
          alignment: Alignment.center,
          child: Stack(children: [
            InteractiveViewer(
              maxScale: 2,
              minScale: .1,
              constrained: true,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              transformationController: controller,
              child: Stack(children: <Widget>[
                CustomPaint(
                  //foregroundPainter: ,
                  child: Image.asset(
                    // change .asset to .file for async loading
                    widget.imagePath,
                    key: key,
                  ),
                ),
              ]),
            ),
            const Align(
                alignment: Alignment(0, 0),
                child: Icon(
                  Icons.add_circle_outline,
                  color: Colors.pink,
                  size: 50.0,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    null;
                    //setState(() {});
                  },
                  label: const Text('Mark Impact'),
                ),
              ),
            )
          ]),
        ));
  }
}
