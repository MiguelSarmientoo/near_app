import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CoconutCreekARScreen extends StatefulWidget {
  const CoconutCreekARScreen({super.key});

  @override
  _CoconutCreekARScreenState createState() => _CoconutCreekARScreenState();
}

class _CoconutCreekARScreenState extends State<CoconutCreekARScreen> {
  late CameraController cameraController;
  late Future<void> _initializeControllerFuture;

  // List of points with Everglades National Park facts
  final List<Map<String, dynamic>> points = [
    {
      'position': Offset(150, 300), // x, y coordinates
      'info': 'Fact 1: Everglades National Park is the largest tropical wilderness of any kind in the U.S. and is home to rare species like the Florida panther and American crocodile.',
    },
    {
      'position': Offset(200, 300), // x, y coordinates
      'info': 'Fact 2: The park spans over 1.5 million acres and is designated as a World Heritage Site, International Biosphere Reserve, and Wetland of International Importance.',
    },
    {
      'position': Offset(250, 350), // x, y coordinates
      'info': 'Fact 3: It is the only place in the world where alligators and crocodiles coexist. The unique ecosystem is fueled by the flow of fresh water from Lake Okeechobee.',
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
        title: const Text('Coconut Creek AR Model'),
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
              'assets/images/florida.png', // Update with your image path
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
