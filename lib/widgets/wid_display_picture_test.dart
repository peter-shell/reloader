import 'package:flutter/material.dart';
// import 'dart:io';

// A widget that displays the picture taken by the user.
class DisplayPictureScreenTest extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreenTest({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreenTest> createState() =>
      _DisplayPictureScreenTestState();
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

class _DisplayPictureScreenTestState extends State<DisplayPictureScreenTest> {
  @override
  void initState() {
    myStack = <Widget>[
      Image.asset(
        // change .asset to .file for async loading
        widget.imagePath,
        key: key,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double viewerScale = controller.value.getMaxScaleOnAxis();

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
              onInteractionEnd: (details) {
                viewerScale = controller.value.getMaxScaleOnAxis();
              },
              child: Stack(
                  children: myStack), // myStack initially contains Image Widget
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
                    setState(() {
                      RenderBox box =
                          key.currentContext?.findRenderObject() as RenderBox;
                      Offset position = box
                          .localToGlobal(Offset.zero); //this is global position

                      myStack.add(Positioned(
                          // movement direction is correct but scaling needs some work
                          // below.

                          width: MediaQuery.of(context).size.width -
                              (position.dx * 2),
                          height: MediaQuery.of(context).size.height -
                              (position.dy * 2),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.green,
                            size: 50.0 / viewerScale,
                          )));
                    });
                  },
                  label: const Text('Mark Impact'),
                ),
              ),
            )
          ]),
        ));
  }
}
