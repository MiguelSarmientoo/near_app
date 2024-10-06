import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // List of points with their information about Glacier National Park
  final List<Map<String, dynamic>> points = [
    {
      'position': Offset(150, 300), // x, y coordinates
      'info': 'Fact 1: Glacier National Park covers over 1 million acres in Montana.',
    },
    {
      'position': Offset(200, 350), // x, y coordinates
      'info': 'Fact 2: The park is home to over 700 species of plants and 100 species of mammals.',
    },
    {
      'position': Offset(250, 400), // x, y coordinates
      'info': 'Fact 3: It is known for its stunning glaciers, although many have retreated significantly due to climate change.',
    },
    {
      'position': Offset(300, 450), // x, y coordinates
      'info': 'Fact 4: The park features over 700 miles of hiking trails.',
    },
    {
      'position': Offset(350, 500), // x, y coordinates
      'info': 'Fact 5: Glacier National Park is part of the larger Waterton-Glacier International Peace Park.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get the list of available cameras
    final cameras = await availableCameras();
    // Select the rear camera
    final camera = cameras.first;

    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
    );

    // Initialize the camera controller
    _initializeControllerFuture = cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  // Function to show a dialog with information
  void _showInfoDialog(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: Text(info),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Model View'),
        backgroundColor: const Color.fromARGB(255, 61, 18, 162),
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Camera is ready, show the camera preview
                return CameraPreview(cameraController);
              } else {
                // Show a loading indicator while the camera initializes
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Center image
          Center(
            child: Image.asset(
              'assets/images/glacieri.png', 
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
          ),
          ...points.map((point) {
            return Positioned(
              left: point['position'].dx,
              top: point['position'].dy,
              child: GestureDetector(
                onTap: () {
                  _showInfoDialog(context, point['info']);
                },
                child: Container(
                  width: 20,
                  height: 20, 
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: const Text(
              'Tap on the red dots for more information!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
