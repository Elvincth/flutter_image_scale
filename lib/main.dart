import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double scale = _controller.value.getMaxScaleOnAxis();
    double imageWidth = 1500;
    double imageHeight = 800;
    //Calculate the scale factor to fit the image to the screen (based on width)
    double scaleFactor = (deviceWidth / imageWidth);

    return Scaffold(
      body: Stack(children: [
        InteractiveViewer(
            minScale: 0.1,
            maxScale: 2,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            constrained: false,
            transformationController: _controller,
            child: Image.asset('assets/1500x800.png')),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Positioned(
            child: MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                //Scale the canvas to fit the screen
                _controller.value = Matrix4.identity() * scaleFactor;

                //optional: center the image on the screen
                //Center the canvas on the screen
                _controller.value.setTranslationRaw(
                    (deviceWidth / 2 - imageWidth * scale / 2),
                    (deviceHeight / 2 - imageHeight * scale / 2),
                    0);
              },
              child: Text('Fit size'),
            ),
          ),
        ),
      ]),
    );
  }
}
