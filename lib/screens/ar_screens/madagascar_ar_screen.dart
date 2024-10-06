import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class MadagascarARScreen extends StatefulWidget {
  const MadagascarARScreen({super.key});

  @override
  _MadagascarARScreenState createState() => _MadagascarARScreenState();
}

class _MadagascarARScreenState extends State<MadagascarARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // List of points with facts about Tsaranoro Massif
  final List<Map<String, dynamic>> points = [
    {
      'position': Offset(150, 300), // x, y coordinates
      'info': 'Fact 1: Tsaranoro Massif is known for its steep granite cliffs, making it a world-renowned rock climbing destination.',
    },
    {
      'position': Offset(200, 300), // x, y coordinates
      'info': 'Fact 2: Located near the Andringitra National Park, the massif offers breathtaking views of Madagascar\'s diverse landscapes.',
    },
    {
      'position': Offset(250, 350), // x, y coordinates
      'info': 'Fact 3: Tsaranoro is not only famous among climbers but is also a sacred place for the local Betsileo people, featuring important spiritual sites.',
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
        title: const Text('Tsaranoro Massif AR Model'),
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
              'assets/images/mad.png', // Update with your image path
              width: 350, // Adjust the size as needed
              height: 350, // Adjust the size as needed
              fit: BoxFit.contain, // Maintain aspect ratio
            ),
          ),
          // Overlay clickable points on the image
          ...points.map((point) {
            return Positioned(
              left: point['position'].dx,
              top: point['position'].dy,
              child: GestureDetector(
                onTap: () {
                  _showInfoDialog(context, point['info']);
                },
                child: Container(
                  width: 20, // Size of the clickable point
                  height: 20, // Size of the clickable point
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }).toList(),
          // Text at the bottom
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
