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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                    (deviceWidth / 2 - imageWidth * scaleFactor / 2),
                    (deviceHeight / 2 - imageHeight * scaleFactor / 2),
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
